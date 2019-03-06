Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F593C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E437820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfCFUPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:15:21 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCFUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:15:21 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6pck-1h9t4j42c2-008MXo for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019
 21:15:20 +0100
To:     LKML <linux-kernel@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Announce: kernel meta config tool
Organization: metux IT consult
Message-ID: <40fc7cdf-8940-49c0-7570-25c6d479c7f7@metux.net>
Date:   Wed, 6 Mar 2019 21:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y40NEL2FVdPzxW4hEZVYjP9sTlpzqaHucU8QT34608T/gNtyzWt
 5Umz/v127ywiX8mvL94DHxiw+9Jh+RZxLcUKB56vov8r9/Z/gspKXdnG0sG1Sy2BR9aTq/4
 C0l6UtQtF4BNIbf8WW6yaH3nyquV4xhXaUL/WBGLXRcoqNSCqpePNgNuzROTN63BJn3SvRf
 EYBVszTib50VY366eH8sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6w7VGEziF4g=:lpyV3+XEWRa4CPjXw/pjFZ
 rrFWXy++EolxF99nXJjGli8czrOddSnpisgJC34Ln8XSVkMlCASkbi4Ok18HfeB+jNCvbr0wq
 Q4DcRzndkMj6eLmKri315DYnIZVaRuZyab3XR/8Jht3LjZ8r+IvtLsM33msxPUNtMMWAkvtdJ
 uNbf3BFEE15mRIWcBm4FgxU04p01M1Kic1yZ8/QLieIhkVlaGKa4Vrk6bANiLSIV2e6B64ZO4
 u13h+eN9m/W2WXN8fvJ7fCKAgJ6xvdCRMjz5Hi7NmMF0JISif69uz6KVba/V1DLJXvCT0YWz0
 Z/HKmu3WrxYa4b6oxOlBotRs9hnF0Z8U01uMemOUzaqrvKQCl2vKB7PD87NX2tBrI/JItfq9e
 7DYT1CzJ+PEaRyBv6/T+9OYBBDNo681GuUdhi+pUPL8V4OHShd53mUWTtMwH6UICp1t2/LSIz
 /r05rwEUrc9Yt9GUSj8fKX9nclq7Fmj4M/oesY93xIcX8w0O0D2P3fW5S219CdW32cIDAijM3
 b9whETVQyF+Gjk2h5jZZeMPTVwM/Le/lk2g5gIM1cczrOTlDOLqK9E7sfnUDnGrm+dOX6HTi9
 I3XAxKFmnQdl+iGSfqkgr9PWdW1L+GGyu93f9q7Sh1qGu05xq7v/60r21a1KMUYQ/XixZMtfA
 nAehORu5h79ZFeh3NgPzzC3KpfHbccDEin2fmZmJhIZ+1bROfOj6OhL+6XBiyOyuG8BvHuCUV
 TYDOOhiwacyNqnMGman5f9QrxvLotaVKjyH6t6b9bJJwtQZJGFd6UQZLjtc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I'd like to announce a little tool for helping w/ creating .config's:

I often have to spend lots of time to find out which configs to enable
on a specific board, to get certain features (eg. network, sata,
display, gpu, ...). Even worse: many options require other stuff enabled
before even showing up. And when disabling unneeded stuff, it leaves
lots of other things enabled. (we don't have some `apt autoremove`
kconfig counterpart :().

I've decided to cope w/ that on a higher level and written a little
config generator tool for that - here you can enable high level
features (eg. 'network' or 'display', etc) and it will generate the
actual .config:

	https://github.com/metux/kmct


*MAYBE* this could become a good alternative to defconfig's ?


have fun.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
