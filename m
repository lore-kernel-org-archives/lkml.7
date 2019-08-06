Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141262173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565126436;
	bh=MsxTnG5JNtSiW+FKb+v5FryeOOGTE5+yhHITDeZhdag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UUmyy+lKpBjwESL6AdFUaSrbpq3U+BGzC90vzEhFfz9DPXTaYdVl8+RBl9+2nYnr+
	 H7qWZeBxUUw8blKQSNcNOibqq5/Z53m28THLLkxl1WYO9Ih3Vxf8taUOeavS0du8+G
	 XQtRB3yHdxRXYgR5eV6eP+EslAH+xUS7I12SMqkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHFVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfHFVUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:20:34 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0ED92186A;
        Tue,  6 Aug 2019 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565126433;
        bh=MsxTnG5JNtSiW+FKb+v5FryeOOGTE5+yhHITDeZhdag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F77hzA4YRU9VX2jmxmf3AGaoQQn9xmUUWOSoFg0zKt1EE6pZr4wQG+JoCzUSHWX9Y
         a8RqfLVfuDeGHuIsxFCRZdyhGusjDp+ZV5L4DF0kXtbmwwsAu8X0vTGil0Lsj5dIfy
         IuI09DZCV1NGmhMrdRN+4y11l+lPQodPIHhFTFtY=
Received: by mail-qt1-f177.google.com with SMTP id x22so12753033qtp.12;
        Tue, 06 Aug 2019 14:20:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXv6iQI2JfXzsytxwsuMFZmbeYXd2ifJ2FzYDrGUJaC4JRtfFhL
        y9Ni36UBD40yid/mx9+q4Ez6Zv2U9E8hqaOTrg==
X-Google-Smtp-Source: APXvYqz96I8Q42e8SKyosq7yJdIWn+9w1J3Nhuf5vrzwshLnzPBxU2De+FJQk8x2UyEHhRELUr4rKAAgemcfwGPDMnw=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr5114419qve.148.1565126432834;
 Tue, 06 Aug 2019 14:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com>
In-Reply-To: <20190806192654.138605-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Aug 2019 15:20:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ9P+HGE6OVASv8AqkozoFEkaiC6Er4LH=S3KHv202JCw@mail.gmail.com>
Message-ID: <CAL_JsqJ9P+HGE6OVASv8AqkozoFEkaiC6Er4LH=S3KHv202JCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/platform: Fix fn definitons for of_link_is_valid()
 and of_link_property()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
>
> of_link_is_valid() can be static since it's not used anywhere else.
>
> of_link_property() return type should have been int instead of bool.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
