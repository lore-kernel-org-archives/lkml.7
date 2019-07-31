Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D622067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtWLln2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfGaFqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:46:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33043 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfGaFqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:46:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so31197844pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 22:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uao5bjHpVUOK+0NKYRiD++G1RQ9m6s2L9wyXdVkAQpA=;
        b=JtWLln2yoEty9uAo7+ZPWwi0Q/RCE9qewEGcFD8mqWk/2mZCRc/x/AYiv7nDRtAcI/
         dCf0sdyo6j1RNGOEkRixlwotC0CFKny139MgNU/3+VmQE8JB3sLT3Ook0sB9GhLbGwhP
         5N3+HhQChxvh23eLc2Hb4QhJJanOJDEI70wxRabvXMSt3hppgs2SyCA+dpVxXwZPWe4s
         hGGWg7dZlVLMKj3AQFqy9we5gofcBfNzccGkmY7jNsbFKeAu5US/FVBLnuN47jtyFkOr
         r8NYCI9E7DqQkNO5rXBkoIHXCkWSKA29u6oQDjHDEC8AWxTXTXXhfreH33EENdS6fJFV
         06gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uao5bjHpVUOK+0NKYRiD++G1RQ9m6s2L9wyXdVkAQpA=;
        b=qP2OadYWenSsHi1tXGhJAFcNVyut2WKXtM49GQDfjpSI1tPw0pqyjAhGFFhUFJn637
         6AMrLW3AbUdnG4eitgTVwIhUsKu2bPj3qEx4wfDjeJGSik6YljQfyAnScGV82WqxeCQp
         OKcZH9by9k2eEeQtkyjlGqpkD+DURJ/bpKB3h53+SMa6/twdmhEX6+teDKk6rqVSoGwH
         M9TcTLuR1MWVnzO6OiK3rjU2M0TYw36SycnGSgzuOrOKA8lRTRP//inFrvlG8H6BP93t
         JAdiSAPDyYXFIIhjdgi+/v8NIDFMF8/FBZac0/IPwbowUZnHNKONtESw/bOoQGCjHDvI
         MHIg==
X-Gm-Message-State: APjAAAWqqh6E4vwkUjQpoMrbyHGYGzrj9O2nvIZtNF82rJTl0xRgjCaQ
        WujmQkjje4VHn2Y2OUNWZAs=
X-Google-Smtp-Source: APXvYqypyhLbNH6a1NPexSpbeMe9IpVtPIzWfHam7ICgtSGzg97ENqrRgMYd+jntVe8DO/vJfCRZ9g==
X-Received: by 2002:aa7:9359:: with SMTP id 25mr44250596pfn.261.1564551993984;
        Tue, 30 Jul 2019 22:46:33 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id k70sm648127pje.14.2019.07.30.22.46.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 22:46:33 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/1] x86/boot: save fields explicitly, zero out everything else
Date:   Tue, 30 Jul 2019 22:46:26 -0700
Message-Id: <20190731054627.5627-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

This uses the "save each field explicitly" approach that we discussed
during the first review [1]. As in [1], this is motivated by a desire
to clear the compiler warnings when building with gcc 9.

This is difficult to properly test. I've done a basic boot test, but
if there are actually errors in which items get zeroed or not, I don't
have a good test to uncover that.

[1] https://lore.kernel.org/r/alpine.DEB.2.21.1907260036500.1791@nanos.tec.linutronix.de

John Hubbard (1):
  x86/boot: save fields explicitly, zero out everything else

 arch/x86/include/asm/bootparam_utils.h | 62 +++++++++++++++++++-------
 1 file changed, 47 insertions(+), 15 deletions(-)

-- 
2.22.0

