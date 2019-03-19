Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4768C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C98920863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="fm/sqXni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCSRTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:19:31 -0400
Received: from erza.pados.hu ([176.9.136.194]:38336 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfCSRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=To:Subject:From:Content-Type:Date:MIME-Version:From:
        Subject:To; bh=/Zi/X5qQBKuHmJK/ovPW+jEEl03FoYfj4mlQYSKLT64=; b=fm/sqXni+MHzsb
        avPtsDwh7aiFWu3E3xqDDjiKMQsk+xLJOFceMwvm9kFGvPB3TYQyF7Zd9r6IQzu1RrOTek+3k6cb+
        oWpdcTC1ELBiniF0jb/WvQXVWiXHebIXiuJYiBtqmURwghhUhG/YB8EWxup6xMz9OhE5aWwPPYLHK
        pdcNfjuerU2Ch6gTzAVyWoSllQeaSccnfnircaswjT2W4SalKtg0ycriOakfG/Y7QTMUe65sFP/N6
        C7x98jzymY4iSUxplxQRBpqPPqaTXYluYPKj/zwBaPEy/34qeDB4QlVCQ2DD+3a5iOX5+PU8YigjX
        FHhkC32lex1OXnrlwFmg==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1h6IOc-00071O-3s; Tue, 19 Mar 2019 18:19:26 +0100
MIME-Version: 1.0
Date:   Tue, 19 Mar 2019 17:19:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <b01d128ac25cdd574856b53d9483cb73@pados.hu>
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
To:     "Johan Hovold" <johan@kernel.org>,
        "Oliver Neukum" <oneukum@suse.com>
Cc:     "Loic Poulain" <loic.poulain@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20190319131409.GL6124@localhost>
References: <20190319131409.GL6124@localhost>
 <20190217175901.3986-1-pados@pados.hu> <1550481432.11088.4.camel@suse.com>
 <20190319103659.GA3178@localhost> <1552994106.14757.34.camel@suse.com>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  >> On Di, 2019-03-19 at 11:36 +0100, Johan Hovold wrote: >>
    On Mon, Feb 18, 2019 at 10:17:12AM +0100, Oliver Neukum wrote: >>> On So,
    2019-02-17 at 18:59 +0100, Karoly Pados wrote: >>>> Current GPIO c [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Di, 2019-03-19 at 11:36 +0100, Johan Hovold wrote:=0A>> On Mon, Feb=
 18, 2019 at 10:17:12AM +0100, Oliver Neukum wrote:=0A>>> On So, 2019-02-=
17 at 18:59 +0100, Karoly Pados wrote:=0A>>>> Current GPIO code in cp210x=
 fails to take USB autosuspend into account,=0A>>>> making it practically=
 impossible to use GPIOs with autosuspend enabled=0A>>>> without user con=
figuration. Fix this like for ftdi_sio in a previous patch.=0A>>>> Tested=
 on a CP2102N.=0A>>> your patch is looking good to me, but I am afraid th=
ere are issues.=0A>>> How do the GPIO lines on the device interact with U=
SB reset and system=0A>>> suspend?=0A>> =0A>> What was your concern here,=
 Oliver?=0A>> =0A>> If you have a device resetting or losing power (for r=
eset_resume) the=0A>> GPIO lines will revert to the default. But that cha=
nge is not reported=0A>> to user space, is it?=0A> =0A> This driver doesn=
't support reset_resume() so that shouldn't be an=0A> issue, right? We'd =
disconnect (deregister the gpiochip) and re-probe=0A> instead.=0A> =0A>> =
So the original patch is correct, but there are more situations rather=0A=
>> than suspend which could trigger the problem.=0A> =0A> This patch just=
 added the missing auto-resume handling, but, yeah,=0A> there may be devi=
ces out there for which things may get out of sync if=0A> they lose state=
 over suspend. I think Karoly confirmed this wasn't the=0A> case with cp2=
10x.=0A> =0A=0AThe way I tested this is very simple: I just toggled an ou=
tput pin. If the device=0Awould lose its state during suspend, then the p=
in state would return to its factory=0Adefault as soon the it went into s=
uspend. Since the LED stayed stable over suspend=0A(I connected an LED), =
it seems these devices don't lose state. I did not, however,=0Atest all d=
evice state in detail to see if every setting remained. I cannot vouch fo=
r=0Awhether *all* state is retained.
