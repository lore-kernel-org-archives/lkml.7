Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236882054F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPlsGHb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfHNNPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:15:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfHNNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:15:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so2797654wrd.7;
        Wed, 14 Aug 2019 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=l+DBXb28UlWmpaDB+1JSMKN1QA0f4oxNynDruzjGeUQ=;
        b=uPlsGHb95cC8NgoZoj0H0Ac8di2gv5OtlJm6ZAeD2k/toyaIqSch32S62gmsQqyz8v
         1xE3G75L/vUVfvltuFbCYmSzwItVFwU/qyu8z46VC5XgeYFzaXphBvF6CimOHmnQAwdf
         Nzk+TnXfgc0ImLDv7UjLIQnrYAxHJIj4EKKKrjUSYGAvSwpsOasj/MhR8t1Qe4b/zlq/
         fzwTzeir3WtY/zIldQ+t2Myu1D0vBMc9n6sVeogMaeoI3VzOUPghP6IUbFCH8418qwaU
         Nr6HZvVduLlXln5Z8/7DTubX6ukCVMhNKteiGq9/inC2/rkoUvoOqfEArE1iKJfJKzoS
         aQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=l+DBXb28UlWmpaDB+1JSMKN1QA0f4oxNynDruzjGeUQ=;
        b=Z2rCvnRKU9oWfWo55M1SfBYfMJvRANGLuG8HHIPXVKcAobhnWuSmGXAYnmPnd1uNev
         0RFt4IEqv5vnEwHP4OEkZiafXy6uqdGLeE6wez2VKxOKQfgR/Xi5MTKD4SfxJ8HIpSgV
         IGFWNV3hmaHAVSyxI8TVjbbn/mATwMa7lVzQ5EiwrIGnkn78k/MMwWJeGi3PsNZXuGfL
         0xcnnptQStcjVqw95YXEQz16TYseN8LG6BRQzQvYbJawn6p6frD3N4tVJf4OMfiQq44f
         9t3C9uwpzUH1o56bGf+132bL7g/CIOpllza+YrT9uK4OE+t4CV5Mmza88YhqYGLLac4e
         mgUw==
X-Gm-Message-State: APjAAAWAAtHAihG1+Yxnm0T7Uh5TXScsdOGK+IdmO+8EanY3rt1lAfft
        vP0sAmE5+iCLRXw8jYrZna4=
X-Google-Smtp-Source: APXvYqwsZx99AiaojhhlGOTWmFsuPCcQ2lZGzaWrlhqpWyE0N8zODSVZNQVlRAff82QSaQamKQaLbw==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr23712313wrn.121.1565788504202;
        Wed, 14 Aug 2019 06:15:04 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id t19sm4622137wmi.29.2019.08.14.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 06:15:03 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kexec on rk3399
Date:   Wed, 14 Aug 2019 15:15:02 +0200
MIME-Version: 1.0
Message-ID: <4fc3e5b5-31fe-41f6-8031-b37454f21437@gmail.com>
In-Reply-To: <87v9uzaocj.fsf@gmail.com>
References: <ebcb52be-2063-4e2c-9a09-fdcacb94f855@gmail.com>
 <c6993a1e-6fc2-44ab-b59e-152142e2ff4d@gmail.com> <87v9uzaocj.fsf@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 14, 2019 3:06:04 PM CEST, Felipe Balbi wrote:
> Hi,
>
> Vicente Bergas <vicencb@gmail.com> writes:
>> On Monday, July 22, 2019 4:31:27 PM CEST, Vicente Bergas wrote:
>>> Hi, i have been running linux on rk3399 booted with kexec fine until 5.2
>>> From 5.2 onwards, there are memory corruption issues as reported here:
>>> http://lkml.iu.edu/hypermail/linux/kernel/1906.2/07211.html
>>> kexec has been identified as the principal reason for the issues.
>>>=20
>>> It turns out that kexec has never worked reliably on this platform, ...
>>=20
>> Thank you all for your suggestions on where the issue could be.
>>=20
>> It seems that it was the USB driver.
>> Now using v5.2.8 booted with kexec from v5.2.8 with a workaround and
>> so far so good. It is being tested on the Sapphire board.
>>=20
>> The workaround is:
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -133,6 +133,13 @@
>>  =09return 0;
>>  }
>> =20
>> +static void dwc3_of_simple_shutdown(struct platform_device *pdev)
>> +{
>> +=09struct dwc3_of_simple *simple =3D platform_get_drvdata(pdev);
>> +
>> +=09reset_control_assert(simple->resets);
>> +}
>> +
>>  static int __maybe_unused dwc3_of_simple_runtime_suspend(struct device=20=

>> *dev)
>>  {
>>  =09struct dwc3_of_simple=09*simple =3D dev_get_drvdata(dev);
>> @@ -190,6 +197,7 @@
>>  static struct platform_driver dwc3_of_simple_driver =3D {
>>  =09.probe=09=09=3D dwc3_of_simple_probe,
>>  =09.remove=09=09=3D dwc3_of_simple_remove,
>> +=09.shutdown=09=3D dwc3_of_simple_shutdown,
>>  =09.driver=09=09=3D {
>>  =09=09.name=09=3D "dwc3-of-simple",
>>  =09=09.of_match_table =3D of_dwc3_simple_match,
>>=20
>> If this patch is OK after review i can resubmit it as a pull request.
>
> not a pull request, just send a patch using git send-email
>
>> Should a similar change be applied to drivers/usb/dwc3/core.c ?
>
> Is it necessary? We haven't had any bug reports regarding that. Also, if
> we have reset control support in the core driver, why do we need it in
> of_simple? Seems like of_simple could just rely on what core does.

the workaround has been tested patching only core.c with
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1561,6 +1561,13 @@
 =09return 0;
 }
=20
+static void dwc3_shutdown(struct platform_device *pdev)
+{
+=09struct dwc3 *dwc =3D platform_get_drvdata(pdev);
+
+=09reset_control_assert(dwc->reset);
+}
+
 #ifdef CONFIG_PM
 static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 {
@@ -1866,6 +1873,7 @@
 static struct platform_driver dwc3_driver =3D {
 =09.probe=09=09=3D dwc3_probe,
 =09.remove=09=09=3D dwc3_remove,
+=09.shutdown=09=3D dwc3_shutdown,
 =09.driver=09=09=3D {
 =09=09.name=09=3D "dwc3",
 =09=09.of_match_table=09=3D of_match_ptr(of_dwc3_match),

and leaving dwc3-of-simple.c as is, the issue persisted.

Regards,
  Vicen=C3=A7.

