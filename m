Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E6120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDATe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:34:29 -0400
Received: from sauhun.de ([88.99.104.3]:33342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDATe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:34:28 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 7CDCA2C7BF4;
        Mon,  1 Apr 2019 21:34:25 +0200 (CEST)
Date:   Mon, 1 Apr 2019 21:34:25 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190401193424.sqnapthocznhjqok@ninjato>
References: <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6wzssfbyckocm2u5"
Content-Disposition: inline
In-Reply-To: <20190401185346.GP3430@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6wzssfbyckocm2u5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Well, seeing the code, I actually remembered that this test is still
> there to ensure the core will properly block. If you remove that test,
> the other ones should all timeout.

Thanks for your assistance! What I did just now was to make use of the
'uie_unsupported' flag. This is the outcome:


[==========] Running 7 tests from 2 test cases.
[ RUN      ] rtc.date_read
rtctest.c:49:rtc.date_read:Current RTC date/time is 01/01/2000 00:13:23.
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read
[       OK ] rtc.uie_read
[ RUN      ] rtc.uie_select
[       OK ] rtc.uie_select
[ RUN      ] rtc.alarm_alm_set
rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 00:13:32.
rtctest.c:148:rtc.alarm_alm_set:Expected 0 (0) != rc (0)
rtc.alarm_alm_set: Test terminated by assertion
[     FAIL ] rtc.alarm_alm_set
[ RUN      ] rtc.alarm_wkalm_set
rtctest.c:195:rtc.alarm_wkalm_set:Alarm time now set to 01/01/2000
00:13:37.
rtctest.c:202:rtc.alarm_wkalm_set:Expected 0 (0) != rc (0)
rtc.alarm_wkalm_set: Test terminated by assertion
[     FAIL ] rtc.alarm_wkalm_set
[ RUN      ] rtc.alarm_alm_set_minute
rtctest.c:239:rtc.alarm_alm_set_minute:Alarm time now set to 00:14:00.
rtctest.c:258:rtc.alarm_alm_set_minute:data: 1a0
[       OK ] rtc.alarm_alm_set_minute
[ RUN      ] rtc.alarm_wkalm_set_minute
rtctest.c:297:rtc.alarm_wkalm_set_minute:Alarm time now set to
01/01/2000 00:15:00.
[       OK ] rtc.alarm_wkalm_set_minute
[==========] 5 / 7 tests passed.
[  FAILED  ]

I wonder why the_set_minute tests pass, but the other ones fail. I also
wonder why I need the uie_unsupported flag? It's been a while since I
dug into the RTC subsystem, I may be missing something. But I see the
UIE code finally calling into set_alarm for some codepath. We have that
for DA9063, but it is not executed for the UIE test of rtctest. However,
it seems the driver doesn't support this in an optimal way, because
there is a currently unused update interrupt which should be used for
UIE, or? I also wonder why all this works fine for Steve.

Thanks,

   Wolfram


--6wzssfbyckocm2u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiZ8AACgkQFA3kzBSg
KbbGkBAAiBvdeqfhYI1sJOdRd02nySMREaOqFHxsZYXnoTum4+NSjTZ+dYDPfEa2
YuiK/e+LVAgPbOiunkQjcaqKH3saFs6itQP6iAYVPwwIAmPMNl35NYQ5WVUdPadT
ON6lNvJWYR6JILnj+pBH4DUnpezXhFsegDHGL1N6RCo/+lTbUXttRPDfv5sU80GO
gnOAISqN/BATYWcYxu8InHWTQJWUl8+agovnhzqOis1Moa4GYZsuk7JKApSqevQB
iiy42ECFrbZkjmKzhvvYJzHk0dLR6HvPYaEeYPhvKNt4xPlNFdTPaHZQqhDMHet7
pp12ch/3FJGhZSh4jb7EBs3Zk+9r5oqJqMUb5AHpLKvvxOaMy9VzI8dxd+7s9tL4
jMW4umzAsXU7YkWWdFaTLs5HLpKqat0rpMgDgv93VBWEGiEJfR3XSVTGT/f03b0N
FluixG6uEpvmy9zzn57KY4o8hCOEQSSMBJlnD+rYPdpGFO+RzNW6PfQsLaSzXFhA
mtSr67+uvoT0+FJxXEGJbqyKpawh961CWG8fqEjHJLcwz55PviApr6SnREuTAaaW
OY52NskslmQn6sYebWhxTBmdSW7+18EqeL+UaYD7+ImcUsb0R75IzYLnEuMK/i3U
yyLhQtaCBP4NbrZ+kaXSlHXg0xd++fNXRpJm4S+E9tQVQQ30UiA=
=7AuM
-----END PGP SIGNATURE-----

--6wzssfbyckocm2u5--
