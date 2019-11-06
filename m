Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25DD207FA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="mfw9WvE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfKFGlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:41:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37652 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfKFGlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:41:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so11588079pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 22:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8lztbuGXtEogRXJuFerbz/ny9VEKOaNJSM1lQ3x6Fs=;
        b=mfw9WvE5QlPdCdwoH4OTzfFy2KQDUPqW9gC9HaEKVtVb6u1YC2Xbxj0+MdP/dfSs5q
         GnVOiVNEN0Ev8dUbc1tdjr8mpNKIuQWYJIheC+rbLa6Px1Qw5icAkv+JAwYO1PlrMBj7
         C7xCs4J100rYtPzT7yogn3gwgcZr+MZpStDoyyLkYdQ8tr9oB/NGMdRWcuD3uyVnvGyh
         ONJi1f9Mnv9UsQQgddjRv5jJHL15UCU0AOEa2xYT//PpDusX38OxwXVjFE85I8U5ZY6X
         BzgKoRPBIqo8PsF7WJBUMoes1mJVhaX0Q2pGZUQOSy+O6IO/cfJvBRuwsayJZZ6y2rTE
         4nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E8lztbuGXtEogRXJuFerbz/ny9VEKOaNJSM1lQ3x6Fs=;
        b=JZ4DrwbCF52ogzLlR4oxnvrjnDCdVk1Qc0d6m2ZPYW7ztB64z/4HtHLP8gfy6+eGRC
         QAm773Hp4HRSxljVE2mgHahdIcybM7QeG225sDeExHJJ1eQmOxq5h0Ceo4PZ2Z6kgO3F
         z2YXtnMTBujgbCQ/9KbaDhpXYlTiIgCnT3s3iWV7tS4rpN6fbN1xKnT4VJRiLvaVUDCW
         CrXR1afazDRpAdTmuoMsBlZdDzE12T2jckmBBdWX7Qot6rxytJIV36Knlw6UgPkGz2D2
         230/2yOst3WrR6EPFwww892flSDq+ug6wjRnOmWTZWmtOtmY7OiiLvNkPYCOxBHDM6J6
         zWBQ==
X-Gm-Message-State: APjAAAUCoWop+yc+/kpiPSt7cXB02g6MuRpdzQ+gjN/4g7+cXSXD4mwA
        n0nTKU+ZzvIN1Ror5veMRDM2eg==
X-Google-Smtp-Source: APXvYqyHRJoGFmWTM2Lh7PQozJSs8NGAL4XSVwYtlNLsTuZqiolravOvDOAoW0UlaZv1/GKN6nKmEQ==
X-Received: by 2002:a63:1242:: with SMTP id 2mr1054261pgs.288.1573022495425;
        Tue, 05 Nov 2019 22:41:35 -0800 (PST)
Received: from [10.16.129.137] (napt.igel.co.jp. [219.106.231.132])
        by smtp.googlemail.com with ESMTPSA id l24sm21102992pff.151.2019.11.05.22.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 22:41:34 -0800 (PST)
Subject: Re: [PATCH v2] uio: fix irq init with dt support & irq not defined
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Dragos Bogdan <dragos.bogdan@analog.com>
References: <20191105072807.14420-1-alexandru.ardelean@analog.com>
 <20191105073212.16719-1-alexandru.ardelean@analog.com>
From:   Damian Hobson-Garcia <dhobsong@igel.co.jp>
Openpgp: preference=signencrypt
Autocrypt: addr=dhobsong@igel.co.jp; prefer-encrypt=mutual; keydata=
 mQENBFL7DcgBCADLqQvkQExYdn1UhfLLsvqtoQwS4M0llP4mCMBGntcTQ90viNgmXUp8mode
 GXu6Qcr4uaIO75b8g6XP2g1jP969cDotlAvsjh7uEDR+eZjTDB6XvqQOroQpq80eiBjETesX
 R5elnlLa6H+wsWCtl+xNohjBq+i/c9pC9B4k4CXOcwhxyTk6HB5w7hA502KY4zFmeRsnQyC/
 VHx+TcRYjB5karzbJqWT3t5nEnVgOb34rUXnqbtE7Eyu6Ts1Q6Oyw9FwpzGa/fJI7asX5ahv
 26IJv6dgFbLPL8Gz1dOpcSKjkv2GX6NYNn0iPCgX6leGDEQjhZ1+OpyhxmHjgADz9b15ABEB
 AAG0KkRhbWlhbiBIb2Jzb24tR2FyY2lhIDxkaG9ic29uZ0BpZ2VsLmNvLmpwPokBPwQTAQIA
 KQUCUvsNyAIbIwUJCWYBgAcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEK3AW9cCDHCG
 qdgH/1bDxLkQ0WchfLDGdD7pKJ3X43nouVRjbeuLtCkDMIMzCXLveR0yJ9tRtI37t3LneS/f
 oBCSNZoEED57UjGvYTepub9cqGRDKN56n8OKGM3e0Ph5OAqI1afloiJXa/LBhNDMCzdgFB/a
 oyuiqbD5v1oo73TCsNtHIrotg91jG7SaOHLOfQzy5drgGqM84W63z102YeHOm3jcB0PbUCOj
 x/MPIyxcggTdedlkQFtlTZugCiCllrHcFvG30WEl4lNTF9qOeyhOyiPJRcOVEEXbt3nMcFey
 MkMuNikkLFFq5dZ/7jbxhiQpXrZgdPXhml8lGqezhLPrk86BqtLjy4tm9Qg=
Message-ID: <17b0d90f-5e87-2d40-8b95-d5c25f9f27c7@igel.co.jp>
Date:   Wed, 6 Nov 2019 15:41:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105073212.16719-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-05 4:32 p.m., Alexandru Ardelean wrote:
> This change also does a bit of a unification for the IRQ init code.
> 
> But the actual problem is that UIO_IRQ_NONE == 0, so for the DT case where
> UIO_IRQ_NONE gets assigned to `uioinfo->irq`, a 2nd initialization will get
> triggered (for the IRQ) and this one will exit via `goto bad1`.
> 
> As far as things seem to go, the only case where UIO_IRQ_NONE seems valid,
> is when using a device-tree. The driver has some legacy support for old
> platform_data structures. It looks like, for platform_data a non-existent
> IRQ is an invalid case (or was considered an invalid case).
> Which is why -ENXIO is treated only when a DT is used.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * removed `int irq` variable ; was omitted when porting the patch to a
>   newer kernel base
> 

This also brings the implementation in line with the what is done in
uio_pdrv_genirq.c

Acked-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
