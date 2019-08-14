Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFEDC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A6D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwwUTaFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfHNMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:54:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51253 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfHNMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:54:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so4515922wma.1;
        Wed, 14 Aug 2019 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=wnzpQNcThUX3QcXowxnBBqL4j7IIg0MRcsVT4jZ+WQ0=;
        b=WwwUTaFUjx3mwTYy5bqQydNTcjvb4Mj3YTzlRP+WWEevgrRkOs6SNV6SQIjWAXZKSJ
         5qrhxomUmXZJUtK4teuc5qDa1xXeToy095gJLHKfRdh0CfjwEAWazg5b6yJOir6Qls/Y
         aVPqNQtRo2Ic1NDBkpxyyGZsV74K5wUv9Ayut3OrQklqElanK1V/Gt5ew3jnAT3rOY2h
         kyjKupMoC8hrHtUWKHFUoz5YizXy4wAmH/oOq4MtOY/HDXwOiry6kYcavF+YYBq+XtyF
         GQ2iXY3JB6qRjxzRhqdO3jyhgauwFzFpE9TW5GDxuf+NuFWpOzvOhbl24OGR2vn823Hh
         LOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=wnzpQNcThUX3QcXowxnBBqL4j7IIg0MRcsVT4jZ+WQ0=;
        b=WwsKumqxtYEb/NbfHxmxdrftVxUcZnE7aMMiY5CbHkAB8K5R843i2XR6P5+BMAkOgu
         FbeFEIkjZG29U17jlOwNZqYGPlgKOhEbeYirfY76UUkrpZnjFxNDMW6PuRHja+wrdTxB
         edaeL7Dy0zESLTscmFEh10Cu9r43jGF48Ambin3dju5nKIqmsygpOhdKvsfq4On6h68+
         u7EXNnI9w9AkKdVsmFZ1kDZi+gmdsDT3O4xU1HwPBWLVy4aJe8a+uvL5UFHj1sED5TNF
         jqpIrLv3u60/G+gPklg7oEQDXNVjd5uxiotZGdykBnUiB5He+ZwJuw8i1N1/2exgjM3Z
         ViRQ==
X-Gm-Message-State: APjAAAWS/DlhKcykONG3pYyGENBbgtDxsT8liUQAj9OCkLRUwr4MHcs6
        ChUtMI/Z0tRyV95QLuN0A0mMjmSTats=
X-Google-Smtp-Source: APXvYqx6AefTr2LbCPjkcPD6r87zgcK6uLcRCUKzw5qoY3RHcLdPUUBtabUtohdhw9NKRmdXApfuFw==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr4099609wma.53.1565787238388;
        Wed, 14 Aug 2019 05:53:58 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id k124sm10048136wmk.47.2019.08.14.05.53.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 05:53:57 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
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
Date:   Wed, 14 Aug 2019 14:53:55 +0200
MIME-Version: 1.0
Message-ID: <c6993a1e-6fc2-44ab-b59e-152142e2ff4d@gmail.com>
In-Reply-To: <ebcb52be-2063-4e2c-9a09-fdcacb94f855@gmail.com>
References: <ebcb52be-2063-4e2c-9a09-fdcacb94f855@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 22, 2019 4:31:27 PM CEST, Vicente Bergas wrote:
> Hi, i have been running linux on rk3399 booted with kexec fine until 5.2
> From 5.2 onwards, there are memory corruption issues as reported here:
> http://lkml.iu.edu/hypermail/linux/kernel/1906.2/07211.html
> kexec has been identified as the principal reason for the issues.
>
> It turns out that kexec has never worked reliably on this platform,
> i was just lucky until recently.
>
> Please, can you provide some directions on how to debug the issue?

Thank you all for your suggestions on where the issue could be.

It seems that it was the USB driver.
Now using v5.2.8 booted with kexec from v5.2.8 with a workaround and
so far so good. It is being tested on the Sapphire board.

The workaround is:
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -133,6 +133,13 @@
 =09return 0;
 }
=20
+static void dwc3_of_simple_shutdown(struct platform_device *pdev)
+{
+=09struct dwc3_of_simple *simple =3D platform_get_drvdata(pdev);
+
+=09reset_control_assert(simple->resets);
+}
+
 static int __maybe_unused dwc3_of_simple_runtime_suspend(struct device=20
*dev)
 {
 =09struct dwc3_of_simple=09*simple =3D dev_get_drvdata(dev);
@@ -190,6 +197,7 @@
 static struct platform_driver dwc3_of_simple_driver =3D {
 =09.probe=09=09=3D dwc3_of_simple_probe,
 =09.remove=09=09=3D dwc3_of_simple_remove,
+=09.shutdown=09=3D dwc3_of_simple_shutdown,
 =09.driver=09=09=3D {
 =09=09.name=09=3D "dwc3-of-simple",
 =09=09.of_match_table =3D of_dwc3_simple_match,

If this patch is OK after review i can resubmit it as a pull request.
Should a similar change be applied to drivers/usb/dwc3/core.c ?

Regards,
  Vicen=C3=A7.

