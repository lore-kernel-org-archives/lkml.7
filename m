Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ADDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410520863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="ie5x6XrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCSRMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:12:45 -0400
Received: from erza.pados.hu ([176.9.136.194]:38136 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfCSRMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=To:Subject:From:Content-Type:Date:MIME-Version:From:
        Subject:To; bh=ZxE5l2rXv7JEJCLBCLrJK1Kr4qnavi9EiNGJ48Oj7iY=; b=ie5x6XrDcoPHbz
        7opKQWkJGF6MJX8zCmgRCP2JFX2HJlOjY//asbEB/6aMExtAR1O2nKz+rKym/Wgzj+x2u9jS3hp4C
        wfWO7I32d5ku4SGU5n0rxQOEYPlEn1QcmfIT/fsta2U8n5+sjKhwvF1VlKx3jceG2r0jLyWnUdc0f
        ygKUCJImxKFUkmQHqVV+eNkmAnfwh2BPWBXLqTVgokRYG6aiIrScfb+KdixSjjquW97YbsGLax5eD
        przrsmiqzzchewllGst35j3X750dxmH/qfB8RevXv4PrGuLWfSpyQLrQZ4RDgHCm95RsGpxEjJMeV
        hruvvxckOWYtku4Vcm6g==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1h6IHr-0006ws-N7; Tue, 19 Mar 2019 18:12:28 +0100
MIME-Version: 1.0
Date:   Tue, 19 Mar 2019 17:12:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <c936ea8404f192276e0a42d9da0b7863@pados.hu>
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
To:     "Oliver Neukum" <oneukum@suse.com>,
        "Johan Hovold" <johan@kernel.org>
Cc:     "Loic Poulain" <loic.poulain@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <1552994106.14757.34.camel@suse.com>
References: <1552994106.14757.34.camel@suse.com>
 <20190217175901.3986-1-pados@pados.hu> <1550481432.11088.4.camel@suse.com>
 <20190319103659.GA3178@localhost>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Oliver, USB suspend does not turn off power. Your concerns
    about the situations you list are valid, but my patch is for another problem.
    Not for what happens when power is lost, but because the user couldn't [...]
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was
                             blocked.  See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: suse.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,=0A=0AUSB suspend does not turn off power. Your concerns about =
the situations you list=0Aare valid, but my patch is for another problem.=
 Not for what happens=0Awhen power is lost, but because the user couldn't=
 use the GPIO lines even if=0Apower was on and continous, due to the kern=
el automatically putting the device into=0Asuspend and then all usb messa=
ges failed in this case.=0A=0AKaroly=0A=0AMarch 19, 2019 12:26 PM, "Olive=
r Neukum" <oneukum@suse.com> wrote:=0A=0A> On Di, 2019-03-19 at 11:36 +01=
00, Johan Hovold wrote:=0A> =0A>> On Mon, Feb 18, 2019 at 10:17:12AM +010=
0, Oliver Neukum wrote:=0A>> On So, 2019-02-17 at 18:59 +0100, Karoly Pad=
os wrote:=0A>>> Current GPIO code in cp210x fails to take USB autosuspend=
 into account,=0A>>> making it practically impossible to use GPIOs with a=
utosuspend enabled=0A>>> without user configuration. Fix this like for ft=
di_sio in a previous patch.=0A>>> Tested on a CP2102N.=0A>> your patch is=
 looking good to me, but I am afraid there are issues.=0A>> How do the GP=
IO lines on the device interact with USB reset and system=0A>> suspend?=
=0A>> =0A>> What was your concern here, Oliver?=0A> =0A> If you have a de=
vice resetting or losing power (for reset_resume) the=0A> GPIO lines will=
 revert to the default. But that change is not reported=0A> to user space=
, is it?=0A> So the original patch is correct, but there are more situati=
ons rather=0A> than suspend which could trigger the problem.=0A> =0A> Reg=
ards=0A> Oliver
