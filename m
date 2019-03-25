Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9498BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6DA2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvxECnfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfCYQSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:18:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40917 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:18:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id 3so7419099oir.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RLDRoiBNbIAcIdIMLPqBzAQAHLBoEDdVU4Q4wOwG8Ms=;
        b=SvxECnfSRkC11p+C5ALfZTkc9meVsdEhIfzq7trghnm0/pb2EXiT6M9azSNm1JOYZk
         qPvdzYkGFaVFlK5Jij1L+zl+09EhR/TWwrQ+ODeYvEkhGt9injuE83BpO88WiRy9Y239
         qPpHGNdkvE3mvxd02l696jBoLuE9Qh5MT8iRqi55Y2oHSY0RXLOc/EhNiWFKl8Y0CO1j
         /jVStQo4fwar6VJZnTzu/lVyUQKEe1GAM92oZBmShgoC65F+stAEzurPhILNWg2lvPln
         GbVEF+bMA6jDWIJPewjXX/HwnLXYOmXcx0rLyecXHdyCBQs/e5KLZ9v1XaTmRvDcaECl
         LLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RLDRoiBNbIAcIdIMLPqBzAQAHLBoEDdVU4Q4wOwG8Ms=;
        b=ucgz8WOfMBxpDJQfqWxrR6jauxvNTvDFBUTFFAwxovpk79ENVehcgncZchKHLB4ybS
         C3trivEQjcHo7MK7CEwS7aa9+N9qeFQBDJ84xWFxDBMMWAECRHSxsReII74/cRse0GfA
         wIzbwnag4A6Do56tNPtLVfSWwX91+tvTCq1jdHftllLet41I5y02cJ+KjgW70CIUQelt
         6cXPsB+rVum+s8DGcgy/w1+W6B2DlDjhB1uMkvLeP2u1TppGVbGJsbC+fGZwwhLikLJN
         ODoetsA4x+2StmhX3oXxW0vcvpkxAKk0ZrIFYVtFMwkeDGB9j1SPq7ydrw1Q3lSC0N8o
         6h7w==
X-Gm-Message-State: APjAAAW2FIRc3xu1uBiLjD8dAnyDuGLXyq8661/wpwSdE6Yr79qMnxqA
        u4EfYtK/wbnbJBxmRgOvhug=
X-Google-Smtp-Source: APXvYqzS7odJS1ZMxA3shGVmeIIDMUwsBye/FsKIe8gQKuJ71NTAV2ToHkYbPlits7tnpLa/fXvOJg==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr12392419oif.91.1553530709863;
        Mon, 25 Mar 2019 09:18:29 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id g17sm2288215otq.45.2019.03.25.09.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:18:29 -0700 (PDT)
Subject: Re: [PATCH] powerpc/rtas: fix early boot failure.
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <04c77eea-bda1-2bad-062f-d86d2ce6f192@lwfinger.net>
Date:   Mon, 25 Mar 2019 11:18:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 3:43 AM, Christophe Leroy wrote:
> Commit 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing
> stack pointer while in RTAS") changes the code to use a field in
> thread struct to store the stack pointer while in RTAS instead of
> using SPRN_SPRG2. It therefore converts all places which were
> manipulating SPRN_SPRG2 to use that field. During early startup,
> the zeroing of SPRN_SPRG2 has been replaced by a zeroing of that
> field in thread struct. But at least in start_here, that's done
> wrongly because it used the physical address of the fields while
> MMU is on at that time.
> 
> So the virtual address of the field should be used instead, but in
> the meantime, thread struct has already been zeroised and initialised
> so we can just drop this initialisation.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Fixes: 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

My PPC box now boots OK.

Larry

