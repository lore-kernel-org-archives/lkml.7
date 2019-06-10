Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2CC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3182220859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gbzpln5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390468AbfFJNo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:44:28 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34100 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390156AbfFJNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:44:27 -0400
Received: by mail-qt1-f173.google.com with SMTP id m29so10623999qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GlOa5AWYuEy0cWvebNNXvbMhWK/SQlKTGvJR13KtDA=;
        b=gbzpln5zVB/PmXT2iLPA2ElaWr7aWY2nH1tfDMLxhJfyFw308Aows7Vkwh6+ziHcF2
         kmLhlxUIPq+R5xUr6Y1HWkLjOD6d1jRhEpK/2YPPYdoAFTCQjXbtiUuMVg0ZaeVucMic
         tk64cfUrhw2NNp0bl71PHE+ENt4l1UmK6NbMBIOz+FoISsdZheM7E1rsVv78/JZSQ6C6
         MEB5+/LhkEzAmY/G8xpKM0EU3VoY+Sncc2/rJlgzyeRhG3GWUuSJ1IWPxmuEAFCcngSi
         BGb2O4tqn1tRSh7QaRiuBYCafjDEHWEIum7HyVQW0ZZy7xhZDIP3M0xb+0ls4tgxj1Po
         6gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GlOa5AWYuEy0cWvebNNXvbMhWK/SQlKTGvJR13KtDA=;
        b=cMXUEsOpPY+DNvQ+hdCEAuYghomtxUqM8L9Uqg/8pURiKt5HL9gX+NUPNog9trErxk
         gOpBUT+8wL9X+1i+HxsPKfmkX5YTVS1lz8iygMZlW37PIKZqRk+aZM9zDPnEVHD3e3Q1
         +N4Yx2j2FVWXIhnrDxsJn9CppoK7vXEhZ4nE7NSwh7NknpwdM3dTeKYIdP510JQNra23
         coLNQSU4zOgQtUZUBt8SCncjk+/xCzmo7SBbl4VQaYHWSdFb88KHNG7fNZBluVbodkt3
         BNONGN8BYwZUkoMX3AfZpSTJWLxlcbVITQ/YYezoD4Ao12AtCKOAZAvvBrHN3QychBF4
         qpBA==
X-Gm-Message-State: APjAAAURQ94xXXLksUJljF9Xhp5pSDgl7FfQx5Ubmgf0BG8AFcfBGD5d
        s6UwGpuLkMrhrmrV8ipJRmRqdQ==
X-Google-Smtp-Source: APXvYqzsCSsuUTOm+LNiBGW6RDxOvX0evmGXIygd9Tj5u7Y3Eee+b96fQyqmG3L8e4oFYbo6YbCzCg==
X-Received: by 2002:ac8:595:: with SMTP id a21mr33144837qth.257.1560174266903;
        Mon, 10 Jun 2019 06:44:26 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q56sm2634272qtq.64.2019.06.10.06.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 06:44:26 -0700 (PDT)
Message-ID: <1560174264.6132.65.camel@lca.pw>
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series
 breaks megaraid_sas
From:   Qian Cai <cai@lca.pw>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     James Sewart <jamessewart@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Date:   Mon, 10 Jun 2019 09:44:24 -0400
In-Reply-To: <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
References: <1559941717.6132.63.camel@lca.pw>
         <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
> Hi Qian,
> 
> I just posted some fix patches. I cc'ed them in your email inbox as
> well. Can you please check whether they happen to fix your issue?
> If not, do you mind posting more debug messages?

Unfortunately, it does not work. Here is the dmesg.

https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=AMC35QKPIZBYUMFU
QKLW4ZC47ZPIK

