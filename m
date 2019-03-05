Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4FF2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCENF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:05:27 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:32835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfCENF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:05:26 -0500
Received: from [192.168.1.110] ([95.118.29.230]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mxlio-1hAZDp0g50-00zIfz; Tue, 05 Mar 2019 14:04:59 +0100
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        mingo@redhat.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: guidelines on creating defconfigs
Organization: metux IT consult
Message-ID: <97cbacf8-847f-439c-70da-0a3b8a20a083@metux.net>
Date:   Tue, 5 Mar 2019 14:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ErnbWeWwHlB9LWP5TOdlQizMByWTwmS/8jmPtkxaOTz1hXGNBdJ
 wSHSAH3Or2c0MGWVNMe+Tszu3IW+qHQ8a7FjvA0R8sMHBHO1/po2l50fiFiRUAsIU04i3Eu
 VYkzHDlfQPxqH/cfMoDZcni3/G0ai4KUloJpWgc+cRsYORfS4ItJo67c+nB+QnfXAeMmQCa
 OCwyGsriw1SGxYNIIu5bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dhat8fdK/P8=:FVQr5fKwrkF2tZf+qZZSaW
 nM7LbKYY2LiusZAjH3ORkb4J8Zge1cefgMXvCt0Ee3yzA/k7/p9sGnkhybYd7aDQmzbxXaJyx
 PvU9TDalMuKEU2io44mUUS6Sq1LQW3+chnC4xyAzsUIUTIcMeK5sFtjZHQodLGhcOUGiyFj4k
 k7VMizJeXlXsQETVZ8hylxl3E7YzgKbfTm2O9zR7G8hp0C5sipxZgGm8kTvhIXfYULu4ogoUO
 CqNsM0MiE2DYtolM0Uc5t2sertoQnuaBm3WRLFZya5Dqiy8uoDUNOSJ5qvEPmwoEdydXq3L7a
 zB0l9ADjmWkM3Z3r9MQllvJJg7J+2EooHdNyclsdRUtPcZ5XJNJstpcYBc5nQ6zqFtLobC0i1
 n9DYFJCUERAYVfrrJUK8ftpjrbW6SIYzgVi5TclxuB+tFHxHwIXACvWlNr0xqtttnrSwXInTs
 60h9i0B/NjOceWXRQY/yVUSgB955hKYGsCNsqty3Mw7HKJhmDAnmpZvEX8Tgu9EHAPxaQ/y3g
 wP9dMsxOy588c0Bq+TknVr8kXS77z6kzD2mOWShFC6qbLKQVZYRUOj14wppIqF9Re/IwpvYMF
 RyTBEiSXROcIrdgXOCYawCxykcuEgaiLwhC+k9N2LL2ORGUzNX7dctzJsWtjYfSnzqMf8ODec
 JnPmRWzKfT0IhAckJVwzW+AHixxevnyyKmNzvrOqk8436gaKkXOov+liO+BP6So6AvS3aaXrg
 mmvg+LEZQdlJsHEr2C2WYmYFI08AxTvWtQ8iPIwBndXEViC1gIiEn6zeP34=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I'd like to create a defconfig for the apuv2 board (pretty average
x86, but w/o display, instead a bit of extra gpio/leds, etc).

The big question for me now is: which non-hw-related things should
be included ?

IMHO, it seems clear that it should enable all drivers for all hw
the board actually has. But what about hw that can be plugged in ?
(eg. the board has several pcie and usb slots). Are there any things
that should be enabled by a defconfig ?

Another topic are things like filesystems, initrd, etc, etc.

So, I'd like to know whether there are some guidelines or at least
some consensus on what shall be included in a defconfig.


thx

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
