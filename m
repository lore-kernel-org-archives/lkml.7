Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64D4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E981206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="afjkmONg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKCAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:00:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35615 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfKKCAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:00:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id i19so9967257qki.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 18:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3uxECVPJsGWw8xFiN9zTP40MfjZW/r53fJQviv7WuHo=;
        b=afjkmONguFYTWI/8Q1shfBRC8uIfpMD2pwpJS7Zm9HAT1ZxZh7NUGZyfajm1URqy+v
         mJy7E3biJzqTzt5Bj9xrMG9u8mqwH6Q9SFoZcroI7YD6C4Nrqqb0UQWFGEd4zp4QgLdX
         c+/yDy5/pJ5sQoTQtONn3cIBXj0HFoAS6CucZWLsFMRkFVGmx7GeCeEQ9s8Ak5LZVjgz
         XH3zhh8P1WNdnLFIIgbcf5s5kfXXYE6cOl8jengVkduqYUdbG8rsByq9KlQkN4Dp+zso
         7+vVme86K8u0NMceTbjo6w0h2XhqOP4rLV/quW1sT0EZUoCCQTwAXnOk05wc8uQkHTG1
         dxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3uxECVPJsGWw8xFiN9zTP40MfjZW/r53fJQviv7WuHo=;
        b=Y7ct0vRf/LZ/2fvkd1i+VZRcxYGFKypWV6pP/okKRgKwzdCzGfvp/HGmOko7vJsS1j
         7PYcZ4Yq/GWS9SrYscsHw/7pDCD34f205p3/1R7w6kLK5UCD8icVBUl8l7yy1CKsu0L6
         EzrEfJ+bYX9J0w/rv1AZ2zR95h2hChq4GCux1CErzTxDl4J3OLcJ5HJDsHXeBJ/jYffL
         /p2hFkf3y4BHV0d3jVvHcpHjghKXCM42ZIXOjj2/s51NwMYQA15fCQuYQiCKTU3UHpuR
         bO0pSEiSSI/vmBdUjGWFlsEeoFuwN+efrT+iCQ56Dx/kNs2vWrxHAY0qJZWuyNrwqr5M
         bhSQ==
X-Gm-Message-State: APjAAAXiXa85WxLcx8pykhU4w8x5BP+q8vXMD5J2qjqZoW3xgDS8W4lQ
        pV42ki+CjrHHpXGZdu8l5yG6ltgVs5HgLg==
X-Google-Smtp-Source: APXvYqxjxVPXgw/cW0Vh/oWGFQsLytTM4uqXSs6b+YAMHhBa5jLbNwvmxyjhmQupxKqnESvsxUX4aA==
X-Received: by 2002:a05:620a:704:: with SMTP id 4mr8682583qkc.177.1573437604905;
        Sun, 10 Nov 2019 18:00:04 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y27sm8214773qtj.49.2019.11.10.18.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 18:00:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable scalable mode
Date:   Sun, 10 Nov 2019 21:00:03 -0500
Message-Id: <2BBFF955-5533-43CD-849A-2BA6B2CC1AF2@lca.pw>
References: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
In-Reply-To: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 10, 2019, at 8:30 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> How about "pasid based multiple stages DMA translation"?

It is better but I am still not sure how developers should select it or not w=
hen asking. Ideally, should it mention pros and cons of this? At minimal, th=
ere should be a line said =E2=80=9Cif not sure what this is, select N=E2=80=9D=
?=
