Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9401CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767DC2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd/Jys8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfJ2Lrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:47:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42106 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2Lry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:47:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id a15so1008137wrf.9;
        Tue, 29 Oct 2019 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/TTI53BPrTu7UjSNB/6Zde/szNTNtQeVJ8mD6hzll4=;
        b=kd/Jys8OJtaYytj37wMPpfr7AqETl83AzLSViwAqk7yl+1EOQ80amPKIXb++fjZyvf
         CuGHhyCTniyKWy7h7BcocyCGY6Bq1EE742MOFinQ07GRw4kj3YTNhwLGLKhwkP4MpDiV
         xP5CNJSlSsN1VEBNwrUPwKlyODAMO2jSlXNupjZJdNRUwCRthmO++sx3jlnkO9i7flJ9
         RGLKdcCdsBmGKdNiJBbv59MHPK6cyxHZ5VHa9Qa0hguEM2F4RRPi4tOl7SiBSZu1bnC+
         C9oZ0t7QHegmxJG0Qk7DEd3R1Z84Lvhjl57UTm5HrHPtBnmyOkic4T06pVMpmgCxj87Q
         LY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/TTI53BPrTu7UjSNB/6Zde/szNTNtQeVJ8mD6hzll4=;
        b=iH0y82e95XckkzXKM8XevzA/SkSUaBohTn81qeISyAd0lV1ap7JZqYoSEzAhLUIthc
         LFNHmDMl9Is+GP+hhs4oE5glHPjZN5wQFlbEZ3FCvFgKbV1hmHaXVImmZWdUmy4GlfEa
         8oeEUzxmZ3TsJLLAL6fDW6haGa4sL0sl8LCnErKpHAQn954tilSYc/qGM/CEz0Bpu0ZK
         dAh5tw5ynb5aUEgu1jtkcS4XvOlCR7q3nK2Ncvf7urqR8r62zPS0p/piolBag3uRXTKs
         OIBAfXvSg2WPS8NcapxdLnNJ0sQSfM1CXuSgDEPF0xMJmStuxb596K3UHiD283kTSFhI
         zp7A==
X-Gm-Message-State: APjAAAWmO8Hp34SYWSgSb1a6gZ+NIJ8+oODRScRgTgbuoRt24GUIG20G
        qRvxaDFp9di9HZJoWnk6Qk4=
X-Google-Smtp-Source: APXvYqwBPp4sIPktjFq5wRgWxG0Z/ej7KkeM0pu/84LvUd2ZQ+MAaULUdh83NanIN8AbzE1jo+bvPg==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr2566603wrv.382.1572349672177;
        Tue, 29 Oct 2019 04:47:52 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:c1a7:4ac0:2d11:a4f8])
        by smtp.gmail.com with ESMTPSA id 74sm17489735wrm.92.2019.10.29.04.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 04:47:51 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:47:50 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: detecting misuse of of_get_property
Message-ID: <20191029114750.a7inago2vd2o4lzl@ltop.local>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029104917.GI1944@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:50:58PM +0300, Dan Carpenter wrote:
> +static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
> +{
> +	struct expression *left = expr->left;
> +	struct symbol *type;
> +
> +	type = get_type(left);
> +	if (!type || type->type != SYM_PTR)
> +		return;
> +	type = get_base_type(type);
> +	if (type_bits(type) == 8)
> +		return;
> +	if (type->type == SYM_RESTRICT)
> +		return;

Wouldn't this also silently accept assignments to any bitwise
type: __le32, __be16, ... ? 

-- Luc
