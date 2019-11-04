Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C003CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3DD217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyAJ8njz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfKDKxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:53:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34624 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:53:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id h2so9968889qto.1;
        Mon, 04 Nov 2019 02:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wBiUmcDstWLkNGFI112Kv0VvZlPGkJFQqYWydYG4yjs=;
        b=OyAJ8njzmcrjHgQAGYTuuBXB1hoLuN/6Z6aDFiiaRTX/xJ8g6Mt7m1qJOjy6BTN/c+
         XHoB+20oIlo1Ce6V7JqqxGBZEZbLyzsqj5ColWQqfBi7Wu5lnq8DAzDabndJYuCnV9g6
         T81lB6NP0+rcEzsCRRMHHOZdfTy2WRH0gY8a2ry9dLyYlqXgGIQO9GSaYLC+MIZVIEjH
         oVMyN/P4x5SxlP4ehwUlmpe6NESNcCB3kk2b81jCrVb8L9kK493Kb7hmLmVQPsMnC3mg
         DBVto5peDkrj4fY3kzn582xpYalTGTxVNQQitpDTRQ674NbCPJn7RKqXBVx4xtGr8QxJ
         mo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wBiUmcDstWLkNGFI112Kv0VvZlPGkJFQqYWydYG4yjs=;
        b=dWPv66U/OtUVScG+FWrc2Pw9lQKgqYSXNxxzlQL7GVSFVC/+EmyT2da9F8RPloxGmd
         Y/FUVZkOidmAAtYsBgCql0/RqIvbT6xKO0lX0OwVcwy+N5DDXTG501Y2LdJ2NAgRoxy2
         w3d6yxBy1ot6mJzti5EeK1ziyv33RciXeJcwMJfMOusIyeIo/AZgnRmfoz+NP7Ep2EjD
         P0ls23Cr/gVzRYmb7+Gfm4j2g8/e/ldGuOBD2Sch7XO18YG+wzxvlI54tUty4tP28oZc
         /t5So3lzR85ryr9e/SQd/tKVWZG/bvtrL+VTZAB3eeVNcfa7aFCnc4FFUnsFQQTCY48R
         3vxg==
X-Gm-Message-State: APjAAAVwafrS4ipYqXg30DfhI6N/s3xWW3VZ5s0DVG24+SN8D3gNGByB
        1lqLHCm1VcVnRLozUkiI4DIanzsXdqfQ3qCmbEVWhT8RTew=
X-Google-Smtp-Source: APXvYqziMCwP+xvqtt37T+x49RTUx+d+DF4WMdxTYIbcMUY5Gi8/fJG5C5nyP3s7kOH9HJ/Lcvd2r7d+QwtMZCmQvxI=
X-Received: by 2002:a05:6214:2b:: with SMTP id b11mr21827281qvr.194.1572864784244;
 Mon, 04 Nov 2019 02:53:04 -0800 (PST)
MIME-Version: 1.0
From:   Leon Maxx <leonmaxx@gmail.com>
Date:   Mon, 4 Nov 2019 12:52:53 +0200
Message-ID: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
Subject: [RFC PATCH 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, andy@infradead.org,
        dvhart@infradead.org, corentin.chary@gmail.com, drake@endlessm.com,
        yurii.pavlovskyi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of ASUS TUF laptops on Ryzen CPUs to existing
asus_wmi platform driver and also fixes minor bug.

Leonid Maksimchuk (3):
  platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
  platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
  platform/x86: asus_wmi: Set default fan boost mode to normal

 drivers/platform/x86/asus-wmi.c            | 57 +++++++++++++++++++++--------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 43 insertions(+), 15 deletions(-)
