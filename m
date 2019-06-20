Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194AAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8A62082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFTJZu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:25:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60599 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:25:50 -0400
Received: from marcel-macpro.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4FFC9CEFA2;
        Thu, 20 Jun 2019 11:34:16 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Bluetooth regression breaking BT connection for all 2.0 and older
 devices in 5.0.15+, 5.1.x and master
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190613073518.GA16436@kroah.com>
Date:   Thu, 20 Jun 2019 11:25:48 +0200
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <99BA793B-E069-4974-8194-5C69616109FA@holtmann.org>
References: <af8cf6f4-4979-2f6f-68ed-e5b368b17ec7@redhat.com>
 <20190613073518.GA16436@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

>> First of all this is a known issue and it seems a fix is in the works,
>> but what I do not understand is why the commit causing this has not
>> simply been reverted until the fix is done, esp. for the 5.0.x
>> stable series where this was introduced in 5.0.15.
>> 
>> The problem I'm talking about is commit d5bb334a8e17 ("Bluetooth: Align
>> minimum encryption key size for LE and BR/EDR connections"):
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5bb334a8e171b262e48f378bd2096c0ea458265
>> basically completely breaking all somewhat older (and some current cheap
>> no-name) bluetooth devices:
>> 
>> A revert of this was first proposed on May 22nd:
>> https://lore.kernel.org/netdev/CA+E=qVfopSA90vG2Kkh+XzdYdNn=M-hJN_AptW=R+B5v3HB9eA@mail.gmail.com/T/
>> We are 18 days further now and this problem still exists, including in the
>> 5.0.15+ and 5.1.x stable kernels.
>> 
>> A solution has been suggested: https://lore.kernel.org/linux-bluetooth/20190522070540.48895-1-marcel@holtmann.org/T/#u
>> and at least the Fedora 5.1.4+ kernels now carry this as a temporary fix,
>> but as of today I do not see a fix nor a revert in Torvald's tree yet and
>> neither does there seem to be any fix in the 5.0.x and 5.1.x stable series.
>> 
>> In the mean time we are getting a lot of bug reports about this:
>> https://bugzilla.kernel.org/show_bug.cgi?id=203643
>> https://bugzilla.redhat.com/show_bug.cgi?id=1711468
>> https://bugzilla.redhat.com/show_bug.cgi?id=1713871
>> https://bugzilla.redhat.com/show_bug.cgi?id=1713980
>> 
>> And some reporters:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1713871#c4
>> Are indicating that the Fedora kernels with the workaround included
>> still do not work...
>> 
>> As such I would like to suggest that we just revert the troublesome
>> commit for now and re-add it when we have a proper fix.
> 
> I've now reverted this as it does not seem to be going anywhere anytime
> soon.  After the mess gets sorted out in Linus's tree, if someone could
> send stable@vger the commit ids that should be applied, I will be glad
> to do so.

this took a while to get fixed since some of the is really old code. I just posted a fix that I think covers all corner cases.

https://lore.kernel.org/linux-bluetooth/20190620091731.5823-1-marcel@holtmann.org/T/#u

If I can get a few people to test this, that would be great. Thanks.

Regards

Marcel

