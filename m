Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CABC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08962175B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="QtvtgQvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCWNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:17:59 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39394 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfCWNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 09:17:58 -0400
Received: by mail-wr1-f45.google.com with SMTP id j9so5196836wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mPDo6lberteDo5RSVoSmh8wmI7wBmepPEBzNWxVFCUU=;
        b=QtvtgQvtd1NilZXA3iQ7y03rbU6N7iFuDkm/MPF7mHk6ZbE/66mLnXpjbycR0TKZ6o
         0QGh2Nzhk+6l/rqhxNO1sJb8ddbv/GViPWiN7VhSVkXtgjUvYfT7v5F7vQuJaX3Hn7YR
         lpyTG4ymBIoDuiWYQVz+c4S6zms8ZXLJ6ICv9UoF+vhoOhjEKMLhXj2Vm9hufIctjmgl
         so+zoYdjA0SHrYTrJTBD/oGKIxYyo+Wd/UsOU51pL1KTewdla3Q3DbzK1+8J+JkVVOj7
         vyIQ9FLXQoHmC5Ie9L97Lqz12AI431IJ2Qk3rNCCVwf0yI7rsSZUS31hki79wjomDOlb
         Vm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mPDo6lberteDo5RSVoSmh8wmI7wBmepPEBzNWxVFCUU=;
        b=jHfBJHQsmD5lpHE967M7ULS9e7+zSPQEYiGhUeIJja8tQSRxoGrv+Fx7dP81iimBv2
         MKtCiqpVpnhNXAcUtXC+3OyQrVFyvpPJ6DDZRAiUxB0144gGQ0TU8oisx+ITdmroU28w
         kQYTmTPQRAWxE9NGG6y5d7zl1L3uAeAbTTIaX3TPkEHhxjlQ/CgW8sDUZGCESbyYdniL
         FG2rTYYcrMWvW9xVxDY6Gs+XRU8Q813S4wV+tzIHrFasb+qQkxjP/SIGtqiY1HjBHsqZ
         nAD4RuDhl4DTMT7taJb5lrb5W46YdYaGO1bIt4o58o0BJov4K0yD6juUgxSfkFRxEd5s
         Zzlw==
X-Gm-Message-State: APjAAAXnp8oOgGd1rIuovk3Z9EYbIatN6O4d+GaQEddaEcp0Sjh07xfR
        eRNQkpi43nl/0vbOCqcaCmyLGIS/45VYochI6dJwcrE200w=
X-Google-Smtp-Source: APXvYqxxZquJDabpRKJQ1oM+aXpCjm5xP4iUQMN3wvLJ53k5bFkZ0xi+OJTl5aJpypN11Ot0zH1BVwNeXi6zLHSf1IE=
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr2596818wrx.0.1553347076540;
 Sat, 23 Mar 2019 06:17:56 -0700 (PDT)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 23 Mar 2019 21:17:45 +0800
Message-ID: <CAFRkauDdY9nkB652-xV=X3Fagc_ikZw1p4mno=rQVXxTOYe0pQ@mail.gmail.com>
Subject: regulator: Question about RC5T619 LDO9/10 .enable_reg and
 .enable_mask setting
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Pierre-Hugues Husson <phh@phh.me>, Stefan Agner <stefan@agner.ch>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In drivers/regulator/rn5t618-regulator.c:
The RC5T619 LDO9 and LDO10 have the same .enable_reg and .enable_mask setting:
static const struct regulator_desc rc5t619_regulators[] = {
        ...
        REG(LDO9, LDOEN2, BIT(0), LDO9DAC, 0x7f, 900000, 3500000, 25000),
        REG(LDO10, LDOEN2, BIT(0), LDO10DAC, 0x7f, 900000, 3500000, 25000),
        ...
};

This seems suspicious and looks like a copy-paste mistake.
I don't find public datasheet for rc5t619.
Maybe someone can help to check if it's correct or not.

Thanks,
Axel
