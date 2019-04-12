Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB7C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF562054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDLNQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:16:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDLNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:16:36 -0400
Received: from [192.168.1.110] ([77.9.22.14]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhDN4-1gblT52kvS-00eI4t; Fri, 12 Apr 2019 15:15:57 +0200
Subject: Re: [PATCH V5 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
 <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <24771fbe-0c45-78b0-e96b-6ed31ccdcb7f@metux.net>
Date:   Fri, 12 Apr 2019 15:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:P1HauobrqeS7Nxy1zjrWPNWz2bBbR9RkUCoH4BP5/j5iRvktL6o
 WlozQICSoUUD+JW+Nw+weARs7Ye6ZKZS9DR52s3B1bRmlx5FeZ5qioYBfzJpRERLEafjxU9
 FHLUEUz/JEHu+HcHhtBvGoCvOXVkxgJditdbymnXHEuUQrswxaL9utPXOoHqfCAZqLcHpHN
 s8xH1Ah8wV2sswdvtG8Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pdel6vNP1mA=:lZgvkh+cmAQuHpCDUhmiOc
 Ls7n8sJuRHw1mPWp38vMQFT9MTtbXgss5ujytTFmju1b8uJuH1Ny6FrsvMSVIvyGMS6vkbe+a
 9YifF91xGHQWsFR9gyDbH4JHwulAtlkb0uroPzLyHHoss7fkqrMo566cosLJLYUjKVL8Dtpkx
 JLBLdg8xvM//RpzzIkQdv4PsPbc8F1C1nVtusbf2avMaLvRyLlCg1UGWr0FKL8APqAZU5MAcM
 OYfpmYcOfTUAA40DPFyG++vfmZailhjxiJ+bhv4KSPZ15PzB+vVNp0jW6buu8opESzl1yUq5g
 jqxoGuf3uLRnkxc7fePaJnrC/pHia3HRrw6j8VpFsB1hKERVONsBsZqmF4fM/LnbeETkM3xW4
 19aI0Ymrsz92X7XwrpXq+0DaZDBSISnhg/ki1s/gpYeJLzlyOaYV9Gi5pcA5MqVZjKukw7jwS
 +ZHmFzpHuCwyUkuBIvjxN20gRm/lyRN14vI3sHGVCw9TGTfDP0jUoOggWp1nYPrh7bImLugDN
 ljh7ix+FC1huXZB7lG8l0WFe+jCNfbxcDdgzDYPUN+5rwxpUyPnH+nS44AQbCdGWrGD4cMWpm
 i6u18+itSHijJDKZMncHVThgeXG31UDlan//quwlYJ5BMh1o3F7Z/IY+twst0s3uTe7/vz/V0
 zXh9Pm/ck5nGgymfsaiYLKTjLAZ6UXwz+sf6gANkhdm5Uu3kCS4qNykOrKbQvHnFtjSmZpVKS
 X4j87XPk2BUv8AaC6HgMPpTvDM51xLIWyYR9hbno3Qy2fK59P8XFMpY3bMA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.19 15:30, Stefan Wahren wrote:
> This adds RPM support to the pwm-fan driver in order to use with
> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
> output signal, which generate a defined number of pulses per revolution.

Wouldn't it be better to have a CONFIG_* flag for keeping the kernel
image size smaller when this feature isn't needed ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
