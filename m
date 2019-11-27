Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9042068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVu30Kdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK0OUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:20:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36764 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfK0OUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:20:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id f16so17327515lfm.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=wamHMBQaa4XOhsaqDdFSh25XfJO0kMdpYEg3ciRI0K8=;
        b=vVu30KdkT0zhpzUN8Ukh8+YTght0YZI0KH+emGcTm1Z51FzzgKoupMOPetuYGZPmhr
         hm5Dj2o4GeNaITiezt50OtHC/6IBJgSdJZ+TRScGAVgyq0oV3yytazLjjLQs5aM74qjJ
         +D7KDKCNVe/tBd4NYpx0zqY//yw8HNn0wyv1xBGbCnbaq3TsTM2HHFMC3doY69KpI/cI
         6tQ5DKfq7DHLxkYGkK/yZIMQXHXSz0O4M3RJwpCoQ1QmRFJFaVNM4RNk0npLH0LWJKYi
         qn7J/1oGBUVOYpJoOKO0i4DcbnSRxMcDCT/UdYvOmxcjHEEIgSLZk4kJpV8jkon05gn5
         HLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=wamHMBQaa4XOhsaqDdFSh25XfJO0kMdpYEg3ciRI0K8=;
        b=b7AEQDxVOqhivbf4KsHDF8ktbqLSoE2ZSO5HM+tkextz5SOGhNEhOO8+Gd1z951xP4
         cPSPWx+633mvizSq65CfvoaDx9eVJOeoHGe17uu4yYu1PKdqbLZoIly8rw4PWDLW/eLi
         yPy7Px6i/3o32xZIoz6gbsOAXC7rU91e5eAnc4k1ozH+SKGvJy5jzJZrGU01t7pEiFH8
         w0CspjLw14Udl/3MzS9wYGm6+UGUHrE9K9TpaYKMBirN2OZnW+PXBo2SNPfaSMBKNs9o
         rtAwmBDRc761qLxlcQpSdBNlzi2YT4/1zuilhc//MsvKhp3AHA1E9qECtTmde41VYVYS
         r7kA==
X-Gm-Message-State: APjAAAWZu5R7b2eySbCJ2YJnGbMy5UsX9WPzHRy6hcNLlCEvGL0mMJIi
        mtijQq235F+8Qz95CJkqQEEtfKHZ
X-Google-Smtp-Source: APXvYqyiAZYFPERTWujiH3a5NMZ8DA7T0CNpf3G1csYEXG+vEgi4m3JUEXIJc9dXySzHtDgL6iEnjQ==
X-Received: by 2002:ac2:5549:: with SMTP id l9mr5868027lfk.53.1574864414623;
        Wed, 27 Nov 2019 06:20:14 -0800 (PST)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id r20sm6521570lfi.91.2019.11.27.06.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:20:13 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:20:12 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] z3fold fixes for intra-page compaction
Message-Id: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a consolidation of z3fold stability fixes for the new intra-page
compaction functionality.

Vitaly Wool (3):
    z3fold: avoid subtle race when freeing slots
    z3fold: compact objects more accurately
    z3fold: protect handle reads

 mm/z3fold.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)
