Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11940217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvVcTjsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfDYGbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:31:39 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38085 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:31:39 -0400
Received: by mail-ua1-f67.google.com with SMTP id t15so6890590uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsWrY5rLCYMwsmN6y8s5YmSBG5RMEFfsiL0kEIJ+uHE=;
        b=BvVcTjsg6aQ/vKUyZA2wIskC3DRTeRM1ROL3T+e5YqlkSPEUFT3Cvcbw5L3aUM0OCJ
         LO/wdTyZgs7ncEAilZ+HUMMvwH6Hi+3y3Z9UBVjevkB3I3izPVtdOy+rzrp5syEf+czu
         2vjwlYIqy5Ymmge8c2FwVFT+Ub0O5EQ9+cOW+oI4y0W7PAZb64DcWJ9COpfD2PK2D/tU
         Wd9Gcjmgc7nml25I5E+Dya8iZO/AXUaMvwjonYk/EbiYUuN3L9e6O36KE0sKOb+owlSR
         7TRPlC+kdaepmtWkC/Ad0GrE6a1O7ME0WOPohQFpr9rpN5aVv0qocfv4y157wTa3xHcQ
         ZLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsWrY5rLCYMwsmN6y8s5YmSBG5RMEFfsiL0kEIJ+uHE=;
        b=cBzZYpmCzlpXAlhYwTmIW8vDE+/iuG5eGsRWCeZMQpH+zt9RvoHgfNG/qJKV6y7rtO
         Y/SrJF7+bCzFEZKKuPvfidBNxrKoGeFcaorMnEC6UZSEz/jqq89Wd0gBMnvlnP9K1MG1
         HBX5b26N1S6HqpjHTynIiC6AHhJFu9RIMXcr7LIfSd7KLbTQJbdW0JkpUiENrpfN4tBH
         0ihAg9wYc8G88GCNKnL6y1YBG/GZogofjS00ECkSEqlA0A9RYRfk6FQAkRRe2O2lqXQy
         qoCMgFhFUekqypF4QAYUBCEasHx1X3d8gx9hhFM047k6+0P/oPJDhVr9bDUh8RQ6J+eU
         dtYg==
X-Gm-Message-State: APjAAAVG6neCZy7i40+3MBg8HHs+3rVEsb7HDAxd6O7OSQp9bQicWPIx
        27dn0BIa/hYSemdBsTSkG7M758hMEv18vuEX4dApxg==
X-Google-Smtp-Source: APXvYqzs79V97XmW9k+25z9oHG0lb59Wg3advClSdz/IglhclRiEXSaO+WftnNnFpHzrkdSG/C7twwjStrSXAkxdHQA=
X-Received: by 2002:ab0:7694:: with SMTP id v20mr2008378uaq.60.1556173897438;
 Wed, 24 Apr 2019 23:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553853990.git.amit.kucheria@linaro.org>
 <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr> <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
 <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr> <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
 <903fa0a6-5c40-97b4-1c01-fd84f3e51c62@free.fr> <8e53ea22-d248-8c63-bcda-15b502eb9699@free.fr>
In-Reply-To: <8e53ea22-d248-8c63-bcda-15b502eb9699@free.fr>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 25 Apr 2019 12:01:25 +0530
Message-ID: <CAHLCerPj6MQ0LeqUHM_91NOW1cP0z75DD7oBnR7Q3-8rpCmnww@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: multipart/mixed; boundary="000000000000610ac3058754f8f5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000610ac3058754f8f5
Content-Type: text/plain; charset="UTF-8"

Marc, can you please test these 3 patches on top of my original series?

Andy, patches 1 and 2 fix problems that already exist upstream. They
were not introduced by my series.
Patch 3 fixes an issue with my series where the name of the thermal
zone was too long. You can choose to fold it into the patch titled
"arm64: dts: msm8998: thermal: Add temperature sensors near major
peripherals" or add it as a new patch with a Fixes tag.

On Wed, Apr 24, 2019 at 8:00 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 23/04/2019 15:10, Marc Gonzalez wrote:
>
> > Sure. I can give you a Tested-by once everything works on the MEDIABOX I have.
> >
> > You mention the 4 thermal_zone*/temp failures.
> >
> > What about the cluster0-mhm-thermal and cluster1-mhm-thermal failures?
>
> I have synced up with today's linux-next.

Thanks for the report. Can you add the attached couple of patches and retest?

> # dmesg | grep thermal
> Failed to build cluster0-mhm-thermal zone -22
> Failed to build cluster1-mhm-thermal zone -22

This one turned out to be a silly one, The name of the thermal zone is
restricted to under 20 characters. Fixed that with patch 3.

> # for F in $(find /sys/class/thermal/thermal_zone?/ /sys/class/thermal/thermal_zone??/ -type f); do echo $F; cat $F; done
> /sys/class/thermal/thermal_zone0/uevent
> /sys/class/thermal/thermal_zone0/trip_point_0_hyst
> 2000
> /sys/class/thermal/thermal_zone0/mode
> enabled
> /sys/class/thermal/thermal_zone0/power/runtime_active_time
> 0
> /sys/class/thermal/thermal_zone0/power/runtime_status
> unsupported

<snip>

> /sys/class/thermal/thermal_zone8/type
> gpu-thermal-bottom
> /sys/class/thermal/thermal_zone8/offset
> 0
> /sys/class/thermal/thermal_zone8/slope
> 1
> /sys/class/thermal/thermal_zone8/trip_point_0_type
> hot
> /sys/class/thermal/thermal_zone8/k_po
> 0
> /sys/class/thermal/thermal_zone8/integral_cutoff
> 0
> /sys/class/thermal/thermal_zone8/k_i
> 0
> /sys/class/thermal/thermal_zone8/k_pu
> 0
> /sys/class/thermal/thermal_zone8/temp
> cat: read error: Invalid argument

Patch 2 should fix this and thermal_zone9 below.

> /sys/class/thermal/thermal_zone8/trip_point_0_temp
> 90000
> /sys/class/thermal/thermal_zone9/uevent
> /sys/class/thermal/thermal_zone9/trip_point_0_hyst
> 2000
> /sys/class/thermal/thermal_zone9/passive
> 0
> /sys/class/thermal/thermal_zone9/mode
> disabled
> /sys/class/thermal/thermal_zone9/power/runtime_active_time
> 0
> /sys/class/thermal/thermal_zone9/power/runtime_status
> unsupported
> /sys/class/thermal/thermal_zone9/power/autosuspend_delay_ms
> cat: read error: Input/output error
> /sys/class/thermal/thermal_zone9/power/runtime_suspended_time
> 0
> /sys/class/thermal/thermal_zone9/power/control
> auto
> /sys/class/thermal/thermal_zone9/available_policies
> step_wise
> /sys/class/thermal/thermal_zone9/policy
> step_wise
> /sys/class/thermal/thermal_zone9/k_d
> 0
> /sys/class/thermal/thermal_zone9/sustainable_power
> 0
> /sys/class/thermal/thermal_zone9/type
> gpu-thermal-top
> /sys/class/thermal/thermal_zone9/offset
> 0
> /sys/class/thermal/thermal_zone9/slope

<snip>

> /sys/class/thermal/thermal_zone18/available_policies
> step_wise
> /sys/class/thermal/thermal_zone18/policy
> step_wise
> /sys/class/thermal/thermal_zone18/k_d
> 0
> /sys/class/thermal/thermal_zone18/sustainable_power
> 0
> /sys/class/thermal/thermal_zone18/type
> battery-thermal

This look wrong. TSENS shouldn't have board-specific thermal zones.

<snip>

> /sys/class/thermal/thermal_zone19/k_d
> 0
> /sys/class/thermal/thermal_zone19/sustainable_power
> 0
> /sys/class/thermal/thermal_zone19/type
> skin-thermal

And this too. See patch 1 to fix this existing issue (not introduced
by my series).

--000000000000610ac3058754f8f5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm64-dts-msm8998-mtp-thermal-Remove-skin-and-batter.patch"
Content-Disposition: attachment; 
	filename="0001-arm64-dts-msm8998-mtp-thermal-Remove-skin-and-batter.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_juw7920c0>
X-Attachment-Id: f_juw7920c0

RnJvbSA5NDY5OGUxOWI2MzI5ZTk4NDA0ZmY5YjljYzBjOTBhMzA2MmZhNWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8OTQ2OThlMTliNjMyOWU5ODQwNGZmOWI5Y2MwYzkw
YTMwNjJmYTVlNS4xNTU2MTY5NjM3LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+CkZyb206
IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZz4KRGF0ZTogVGh1LCAyNSBB
cHIgMjAxOSAwMToyMjo1MCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBhcm02NDogZHRzOiBt
c204OTk4LW10cDogdGhlcm1hbDogUmVtb3ZlIHNraW4gYW5kIGJhdHRlcnkKIHRoZXJtYWwgem9u
ZXMKClRoZSBtc204OTk4LW10cCBkb2Vzbid0IGhhdmUgVFNFTlMtYmFzZWQgc2Vuc29ycyB3aXJl
ZCB1cCBmb3Igc2tpbiBhbmQKYmF0dGVyeSB0aGVybWFsIHpvbmVzLiBUU0VOUyBzZW5zb3JzIHNo
b3VsZCBiZSBjb21tb24gYWNyb3NzIGFsbCBib2FyZHMKdXNpbmcgdGhlIFNvQyBhbmQgc2hvdWxk
bid0IGJlIGJvYXJkLXNwZWNpZmljIGFzIHRoZXNlIGVudHJpZXMuCgpUaGV5IGFsc28gc2hvdyB0
aGUgZm9sbG93aW5nIGVycm9yIHdoZW4gdHJ5aW5nIHRvIHJlYWQgdGhlIHRlbXBlcmF0dXJlCgog
ICBjYXQ6IHJlYWQgZXJyb3I6IEludmFsaWQgYXJndW1lbnQKClJlbW92ZSB0aGVzZSBib2FyZC1z
cGVjaWZpYyBlcnJvbmVvdXMgdGhlcm1hbCB6b25lcy4KCkZpeGVzOiA0NDQ5YjZmMjQ4ZDkgKCJh
cm02NDogZHRzOiBxY29tOiBtc204OTk4OiBBZGQgdHNlbnMgYW5kIHRoZXJtYWwtem9uZXMiKQpT
aWduZWQtb2ZmLWJ5OiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+Ci0t
LQogYXJjaC9hcm02NC9ib290L2R0cy9xY29tL21zbTg5OTgtbXRwLmR0c2kgfCAzOCAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4LW10cC5kdHNpIGIvYXJjaC9h
cm02NC9ib290L2R0cy9xY29tL21zbTg5OTgtbXRwLmR0c2kKaW5kZXggZjA5MDEwNjdiMDQzLi42
MGJkZjc0ODVmMGUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4
LW10cC5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4LW10cC5kdHNp
CkBAIC0xNSw0NCArMTUsNiBAQAogCQlzdGRvdXQtcGF0aCA9ICJzZXJpYWwwOjExNTIwMG44IjsK
IAl9OwogCi0JdGhlcm1hbC16b25lcyB7Ci0JCWJhdHRlcnktdGhlcm1hbCB7Ci0JCQlwb2xsaW5n
LWRlbGF5LXBhc3NpdmUgPSA8MjUwPjsKLQkJCXBvbGxpbmctZGVsYXkgPSA8MTAwMD47Ci0KLQkJ
CXRoZXJtYWwtc2Vuc29ycyA9IDwmdHNlbnMwIDA+OwotCi0JCQl0cmlwcyB7Ci0JCQkJYmF0dGVy
eV9jcml0OiB0cmlwMCB7Ci0JCQkJCXRlbXBlcmF0dXJlID0gPDYwMDAwPjsKLQkJCQkJaHlzdGVy
ZXNpcyA9IDwyMDAwPjsKLQkJCQkJdHlwZSA9ICJjcml0aWNhbCI7Ci0JCQkJfTsKLQkJCX07Ci0J
CX07Ci0KLQkJc2tpbi10aGVybWFsIHsKLQkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+
OwotCQkJcG9sbGluZy1kZWxheSA9IDwxMDAwPjsKLQotCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZ0
c2VuczEgNT47Ci0KLQkJCXRyaXBzIHsKLQkJCQlza2luX2FsZXJ0OiB0cmlwMCB7Ci0JCQkJCXRl
bXBlcmF0dXJlID0gPDQ0MDAwPjsKLQkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsKLQkJCQkJdHlw
ZSA9ICJwYXNzaXZlIjsKLQkJCQl9OwotCi0JCQkJc2tpcF9jcml0OiB0cmlwMSB7Ci0JCQkJCXRl
bXBlcmF0dXJlID0gPDcwMDAwPjsKLQkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsKLQkJCQkJdHlw
ZSA9ICJjcml0aWNhbCI7Ci0JCQkJfTsKLQkJCX07Ci0JCX07Ci0JfTsKLQogCXZwaF9wd3I6IHZw
aC1wd3ItcmVndWxhdG9yIHsKIAkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwogCQly
ZWd1bGF0b3ItbmFtZSA9ICJ2cGhfcHdyIjsKLS0gCjIuMTcuMQoK
--000000000000610ac3058754f8f5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-arm64-dts-msm8998-thermal-Fix-number-of-supported-se.patch"
Content-Disposition: attachment; 
	filename="0002-arm64-dts-msm8998-thermal-Fix-number-of-supported-se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_juw7921h1>
X-Attachment-Id: f_juw7921h1

RnJvbSBlZGE3ZGEyZDAwOThkNjYxNzY3MWU2NzY1ODIyNmUzYzVmYjA3MDQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ZWRhN2RhMmQwMDk4ZDY2MTc2NzFlNjc2NTgyMjZl
M2M1ZmIwNzA0NS4xNTU2MTY5NjM3LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+CkluLVJl
cGx5LVRvOiA8OTQ2OThlMTliNjMyOWU5ODQwNGZmOWI5Y2MwYzkwYTMwNjJmYTVlNS4xNTU2MTY5
NjM3LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+ClJlZmVyZW5jZXM6IDw5NDY5OGUxOWI2
MzI5ZTk4NDA0ZmY5YjljYzBjOTBhMzA2MmZhNWU1LjE1NTYxNjk2MzcuZ2l0LmFtaXQua3VjaGVy
aWFAbGluYXJvLm9yZz4KRnJvbTogQW1pdCBLdWNoZXJpYSA8YW1pdC5rdWNoZXJpYUBsaW5hcm8u
b3JnPgpEYXRlOiBUaHUsIDI1IEFwciAyMDE5IDAxOjUyOjQ0ICswNTMwClN1YmplY3Q6IFtQQVRD
SCAyLzJdIGFybTY0OiBkdHM6IG1zbTg5OTg6IHRoZXJtYWw6IEZpeCBudW1iZXIgb2Ygc3VwcG9y
dGVkCiBzZW5zb3JzCgptc204OTk4IGhhcyAyMiBzZW5zb3JzIGNvbm5lY3RlZCBpbiB0b3RhbCwg
MTQgb24gdGhlIDFzdCBjb250cm9sbGVyLCA4Cm9uIHRoZSAybmQgY29udHJvbGxlci4gSW5jcmVh
c2UgdGhlIG51bWJlciB0byBhbGxvdyBzZW5zb3JzIHdpdGggSUQgMTIKYW5kIDEzIHRvIGJlIHJl
Z2lzdGVyZWQuCgpTaWduZWQtb2ZmLWJ5OiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlhQGxp
bmFyby5vcmc+Ci0tLQogYXJjaC9hcm02NC9ib290L2R0cy9xY29tL21zbTg5OTguZHRzaSB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4LmR0c2kgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL3Fjb20vbXNtODk5OC5kdHNpCmluZGV4IDk5ODAxN2Q0ZDg0Ny4uMDYyYTkzYTEy
MTk4IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vbXNtODk5OC5kdHNpCisr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4LmR0c2kKQEAgLTc0NSw3ICs3NDUs
NyBAQAogCQkJcmVnID0gPDB4MTBhYjAwMCAweDEwMDA+LCAvKiBUTSAqLwogCQkJICAgICAgPDB4
MTBhYTAwMCAweDEwMDA+OyAvKiBTUk9UICovCiAKLQkJCSNxY29tLHNlbnNvcnMgPSA8MTI+Owor
CQkJI3Fjb20sc2Vuc29ycyA9IDwxND47CiAJCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47
CiAJCX07CiAKLS0gCjIuMTcuMQoK
--000000000000610ac3058754f8f5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-arm64-dts-msm8998-thermal-Restrict-thermal-zone-name.patch"
Content-Disposition: attachment; 
	filename="0003-arm64-dts-msm8998-thermal-Restrict-thermal-zone-name.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_juw9kjgr2>
X-Attachment-Id: f_juw9kjgr2

RnJvbSA0M2VlMDExMDA2NTYyYmFjMzA5MWZiYmU1NjNkZjg4MzQ2MGU5OGE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NDNlZTAxMTAwNjU2MmJhYzMwOTFmYmJlNTYzZGY4
ODM0NjBlOThhNi4xNTU2MTczNTA3LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+CkluLVJl
cGx5LVRvOiA8OTQ2OThlMTliNjMyOWU5ODQwNGZmOWI5Y2MwYzkwYTMwNjJmYTVlNS4xNTU2MTcz
NTA3LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+ClJlZmVyZW5jZXM6IDw5NDY5OGUxOWI2
MzI5ZTk4NDA0ZmY5YjljYzBjOTBhMzA2MmZhNWU1LjE1NTYxNzM1MDcuZ2l0LmFtaXQua3VjaGVy
aWFAbGluYXJvLm9yZz4KRnJvbTogQW1pdCBLdWNoZXJpYSA8YW1pdC5rdWNoZXJpYUBsaW5hcm8u
b3JnPgpEYXRlOiBUaHUsIDI1IEFwciAyMDE5IDExOjUzOjI3ICswNTMwClN1YmplY3Q6IFtQQVRD
SCAzLzNdIGFybTY0OiBkdHM6IG1zbTg5OTg6IHRoZXJtYWw6IFJlc3RyaWN0IHRoZXJtYWwgem9u
ZSBuYW1lCiBsZW5ndGggdG8gdW5kZXIgMjAKClRoZSB0aGVybWFsIGNvcmUgcmVzdHJpY3RzIG5h
bWVzIG9mIHRoZXJtYWwgem9uZXMgdG8gdW5kZXIgMjAKY2hhcmFjdGVycy4gRml4IHRoZSBuYW1l
cyBmb3IgYSBjb3VwbGUgb2YgbXNtODk5OCB0aGVybWFsIHpvbmVzLgoKU2lnbmVkLW9mZi1ieTog
QW1pdCBLdWNoZXJpYSA8YW1pdC5rdWNoZXJpYUBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvcWNvbS9tc204OTk4LmR0c2kgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9xY29tL21zbTg5OTguZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4
LmR0c2kKaW5kZXggMDYyYTkzYTEyMTk4Li4wMTc1NzgyOWQ1ZjMgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcWNvbS9tc204OTk4LmR0c2kKKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9xY29tL21zbTg5OTguZHRzaQpAQCAtNTM2LDcgKzUzNiw3IEBACiAJCQl9OwogCQl9OwogCi0J
CWNsdXN0ZXIwLW1obS10aGVybWFsIHsKKwkJY2x1c3QwLW1obS10aGVybWFsIHsKIAkJCXBvbGxp
bmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+OwogCQkJcG9sbGluZy1kZWxheSA9IDwxMDAwPjsKIApA
QCAtNTUxLDcgKzU1MSw3IEBACiAJCQl9OwogCQl9OwogCi0JCWNsdXN0ZXIxLW1obS10aGVybWFs
IHsKKwkJY2x1c3QxLW1obS10aGVybWFsIHsKIAkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwy
NTA+OwogCQkJcG9sbGluZy1kZWxheSA9IDwxMDAwPjsKIAotLSAKMi4xNy4xCgo=
--000000000000610ac3058754f8f5--
