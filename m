Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D4420878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfDXHB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:01:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50011 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXHB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:01:28 -0400
X-Originating-IP: 90.88.147.33
Received: from bootlin.com (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 09DB520019;
        Wed, 24 Apr 2019 07:01:23 +0000 (UTC)
Date:   Wed, 24 Apr 2019 09:01:23 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
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
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>
Subject: Re: [PATCH net-next v2] net: mvpp2: cls: Add Classification offload
 support
Message-ID: <20190424090123.5089586c@bootlin.com>
In-Reply-To: <d62a09aa9194784f93d8ca1df6b4607529008a5f.camel@mellanox.com>
References: <20190423075031.26074-1-maxime.chevallier@bootlin.com>
        <d62a09aa9194784f93d8ca1df6b4607529008a5f.camel@mellanox.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saeed,

Thanks for the review,

>> When inserting a rule in a given flow, the location given is relative
>> to
>> the flow :
>> 
>> ethtool -N eth0 flow-type udp4 dst-port 1234 action 2 loc 0
>> 
>> ethtool -N eth0 flow-type tcp4 dst-port 1234 action 3 loc 0
>> 
>> However when removing a rule, the global location is to be used. This
>> location can be retrieved by using ethtool -n <interface>.
>>   
>
>I am not sure what you mean by "the location given is relative to the
>flow", it seems like the rule will end up in a different location than
>the user intended, but looking at ethtool documentation it clearly says
>that the location the user provides is an absolute rule id/location,
>which will be used to delete this rule.
>
>from "man ethtool":
>loc N:
>Specify the location/ID to insert the rule. This will overwrite any
>rule present in that location and will not go through any of the rule
>ordering process.
>
>delete N
>Deletes the RX classification rule with the given ID.

I was unsure about this, so I'm glad you commented. One thing
that made me think what I did could be okay is that the documentation
for ETHTOOL_SRXCLSRLINS in ethtool.h says :

"For %ETHTOOL_SRXCLSRLINS, @fs specifies the rule to add or update.
 @fs.@location either specifies the location to use or is a special
 location value with %RX_CLS_LOC_SPECIAL flag set.  On return,
 @fs.@location is the actual rule location."

I interpreted the "On return [...]" part as if we could rewrite the
location if needed when inserting a rule (although it seems ethtool
doesn't do anything with this return value)

The point for doing so is that we have a clear separation in our
classification tables between different traffic classes, so we have a
range of entries for tcp4, one for udp4, one for tcp6, etc.

Having a "global" location numbering scheme would, I think, also be
confusing, since it would make the user use loc 0->7 for tcp4, loc
8->15 for udp4 and so on.

Maybe in this case I should stick with insertions thay rely on
RX_CLS_LOC_SPECIAL (such as "first", "last", "any") and have a scheme
where priorisation is based strictly on the rule insertion order ?

>So the above example should result in one flow rule in your hardware.
>but according the code below the calculated index in
>mvpp2_ethtool_cls_rule_ins might end up different than the requested
>location, which will confuse the user.

I'm also working on writing a proper documentation for this driver,
including the behaviour of the classifier implementation, hopefully
this would help.

Thanks again for the review,

Maxime
