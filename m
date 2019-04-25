Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF859C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A913C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfDYHM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:12:29 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34635 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:12:28 -0400
Received: from bootlin.com (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 731C2100012;
        Thu, 25 Apr 2019 07:12:23 +0000 (UTC)
Date:   Thu, 25 Apr 2019 09:12:22 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "stefanc@marvell.com" <stefanc@marvell.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>
Subject: Re: [PATCH net-next v2] net: mvpp2: cls: Add Classification offload
 support
Message-ID: <20190425091222.421f37c9@bootlin.com>
In-Reply-To: <78f50363899afdd2a5ca2c8895cafa3b6e6c13ce.camel@mellanox.com>
References: <20190423075031.26074-1-maxime.chevallier@bootlin.com>
        <d62a09aa9194784f93d8ca1df6b4607529008a5f.camel@mellanox.com>
        <20190424090123.5089586c@bootlin.com>
        <78f50363899afdd2a5ca2c8895cafa3b6e6c13ce.camel@mellanox.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saeed,

On Wed, 24 Apr 2019 18:05:51 +0000
Saeed Mahameed <saeedm@mellanox.com> wrote:

>Maybe ethtool doesn't do anything with the return value, but if the
>user is not using any special flag, then the interpretation should be
>absolute location/ID as provided by the user, see below scenario
>example
>
>> The point for doing so is that we have a clear separation in our
>> classification tables between different traffic classes, so we have a
>> range of entries for tcp4, one for udp4, one for tcp6, etc.
>> 
>> Having a "global" location numbering scheme would, I think, also be
>> confusing, since it would make the user use loc 0->7 for tcp4, loc
>> 8->15 for udp4 and so on.
>>   
>
>why ? even with your hw clear class separation, user can use any loc
>for udp4 and tcp4 or any flow for that matter, in case they won't
>overlap.
>
>And in case they do overlap, then I think you must have a global 
>location scheme! take this scenario for instance:
>
>scenario 1:
>loc 0 ip4 action 2
>loc 1 udp4 action -1
>loc 2 tcp4 action -1
>
>This should result of all udp4, tcp4, and ip4 traffic to go to rx ring
>2, even if the user asked to drop udp/tcp4. once rule at location 0 is
>deleted then udp/tcp4 traffic will be dropped.
>
>scenario 2:
>loc 0 udp4 action -1
>loc 1 tcp4 action -1
>loc 2 ip4 action 2
>
>should result in dropping all upd4/tcp4 but allow receiving ip4 on ring
>4.
>
>User doesn't see and should not see your hw tables scheme, i feel that
>for scenario 1 your implementation will drop udp4 and tcp4 since they
>will be separated from ip4 rule at loc 0, which is not what the user
>expects, please correct me if i am wrong.

You're correct, this is what's going to happen with the current
implementation.

>that being said, i think you should keep the global location scheme at
>least from user perspective and respect the prioritization of the user
>inserted rules especially when there are overlapping.
>
>even if there is no overlapping, location could mean: priorities rules
>at lower locations in hw processing so they can get higher performance.

Ok, I'll have to rework the design of the tables a bit to be compliant
with this, but this is achievable.

I'll make sure to CC you on next revisions.

>> Maybe in this case I should stick with insertions thay rely on
>>  (such as "first", "last", "any") and have a scheme
>> where priorisation is based strictly on the rule insertion order ?
>>   
>
>Sure for when the special flags are set, but you will have to report 
>RX_CLS_LOC_SPECIAL on ETHTOOL_GRXCLSRLCNT.
>
>also if you don't want to support the global location scheme then
>return -EOPNOTSUPP/-EINVAL when user specifies a non special location 
>?

Given your review, I'll keep support for the global location scheme.

>> > So the above example should result in one flow rule in your
>> > hardware.
>> > but according the code below the calculated index in
>> > mvpp2_ethtool_cls_rule_ins might end up different than the
>> > requested
>> > location, which will confuse the user.  
>> 
>> I'm also working on writing a proper documentation for this driver,
>> including the behaviour of the classifier implementation, hopefully
>> this would help.
>>   
>
>hmm, i think all driver should be aligned and provide same behavior, at
>least for the non special flag use case,
>vendors must report -EOPNOTSUPPORT if a specific use case operation is
>not supported.

I agree, I'll however document what the limitations are in terms of
supported features, etc.

Thanks for the clarifications, it really helps a lot.

Maxime
