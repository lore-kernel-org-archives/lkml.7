Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B4C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9D2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aalto.fi header.i=@aalto.fi header.b="pU670Cb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfHFTAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:00:20 -0400
Received: from smtp-out-02.aalto.fi ([130.233.228.121]:57279 "EHLO
        smtp-out-02.aalto.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfHFTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:00:20 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 15:00:18 EDT
Received: from smtp-out-02.aalto.fi (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 811F12715D9_D49CB7BB;
        Tue,  6 Aug 2019 18:48:27 +0000 (GMT)
Received: from exng2.org.aalto.fi (exng2.org.aalto.fi [130.233.223.21])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exng2.org.aalto.fi", Issuer "org.aalto.fi RootCA" (not verified))
        by smtp-out-02.aalto.fi (Sophos Email Appliance) with ESMTPS id 5CFE12715C0_D49CB7BF;
        Tue,  6 Aug 2019 18:48:27 +0000 (GMT)
Received: from exng5.org.aalto.fi (130.233.223.24) by exng2.org.aalto.fi
 (130.233.223.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 6 Aug
 2019 21:54:56 +0300
Received: from exng5.org.aalto.fi ([fe80::c840:c193:838f:f99c]) by
 exng5.org.aalto.fi ([fe80::c840:c193:838f:f99c%17]) with mapi id
 15.01.1713.006; Tue, 6 Aug 2019 21:54:56 +0300
From:   Fihlman Emil <emil.fihlman@aalto.fi>
To:     "yauheni.kaliuta@redhat.com" <yauheni.kaliuta@redhat.com>
CC:     "e@kellett.im" <e@kellett.im>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] gcc-9: workaround array bounds warning on boot_params
 cleaning
Thread-Topic: [RFC PATCH] gcc-9: workaround array bounds warning on
 boot_params cleaning
Thread-Index: AQHVTIZ5ZwmQNTpoNka2oFBQBcpa5g==
Date:   Tue, 6 Aug 2019 18:54:56 +0000
Message-ID: <e72c48b3d10540a8b763f5ba862f2b8a@aalto.fi>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.233.0.5]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aalto.fi; h=from:to:cc:subject:date:message-id:content-type:content-transfer-encoding:mime-version; s=its18; bh=DTcRCjzvwexjGwi0bfYpzBB/zMQQ341EDXvwkAQEMi8=; b=pU670Cb04MTtGIj9/Yl+GtcL2tys5tHq8OrfOve1JuTQerYbQsR8YrvVm4cLIcUvIiULoX41ocJsy7/Ehc6zsdMsH6A0ZS79gdrJ1LTELYcN/RYSOIErN50z7tat/gFtjvhnWTPfT/bHTQ1am1wOe7Rt92b43f83wj0+idir/ibySRIx3HkY5Kxsq2TwnW7f9s4NrwThgjtnILfTxE6ZhwywrMdZI7AiXIf2pEoCpVh/eOwLmNVVhitpQeWX9brYsYbva30rCdg+lqzppKJAWKFlMy3SCZ7xXZQYPe1vzuzSgXyxNWGM0D8NtKK6CzbHNiXab7Po9Yu0VmeTKBVVMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should also be possibly to simply cast to u64 and then to u8 * unless
the compiler overzealously tracks out of bound accesses even when
6.3.2.3 #5-6 explicitly allows pointer-integer-pointer conversions like
this and removes previous guarantees. Ie.

memset((u8 *)((u64)(&(boot_params->ext_ramdisk_image))), 0, size)

I apologise for not having the in-reply-to header.

Emil Fihlman
