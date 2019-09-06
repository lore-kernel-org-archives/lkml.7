Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA15621670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LeW70Cwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406248AbfIFTE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:04:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37791 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfIFTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:04:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id i1so7271815edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jojg3lt9aotJnGt5bH33wsrcyv/EEKP9KJRLMGkqesY=;
        b=LeW70Cwz4yP0y+LnTrM6vdUtvCMHjSw1acep3zXSJpi5BYck+TcuH8lwg6BFF+angS
         RDYMTGCVx+3iLx4bIRpfNA69sQlUdbjAfJrE1tIJt9h5xR7KlD59f1teg2zUjKLWji8U
         HtKOfDiAs4fvtxuIYAkhN86SzJ/3DECTbwuraae7Ro4Fnmf/j7wRycV3GekLevRvA4yi
         hN+l2NlmZ43f8LnS3649b2RQBq2URKwBrG03uECmpal6VX2gf/H7cIiJydxgVHNdAVEK
         ZsN2k2L3TJXN4FJXJv8Ww2KRqLaR8luX0x/QO6p8DnbYTUm/7XaIdegqHhHY71r0jRUC
         LkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jojg3lt9aotJnGt5bH33wsrcyv/EEKP9KJRLMGkqesY=;
        b=XeOoX/qR5dzJogrDWTaABcJe0I/Isgz66c1eTiCnPESYDKI5dM/nxu+kahMnfTxDwj
         2Q9sj52+OQlbxw60aHBSsE5A2U+T2dZd9O22VEgFjZxz+orkoE+uzlftGMdVg0agkcZz
         0KVV/iUkSlT/jlx9twGlOgcznZttPAJO2C9dnmajaYP8u0hM1tuszNO3jl7VXEFPxPMJ
         IUYmN3SSSlWs5iIicuHyjrwi5aNBIbF0efK6eeBgaNTB5i6wPWqUhNfT0bvdlHS1H6yk
         mAFF4Cspfgd6k/FgOw1IPWS6HJKrQm9NVKAOw0FI2j0wpmjr2T3E1pPLo3TD8n8iiPoP
         oTdQ==
X-Gm-Message-State: APjAAAXNmT5dgK3Tcsw6jgrr92vn7bx/ZoYMMw1Yt2Fh5pVUsNgPDtZ/
        4+xQ39He96oW3knOXI2cLxAq5+tUi7rtKmLpZufqkQ==
X-Google-Smtp-Source: APXvYqyK1SCAqBB23XwDsQMDwIBa7uh8HdAPqm1/xVvjPDxouORMX2W/oKEVAMQ70bEUmrEuPn+OtVr0upjiCbgyF4o=
X-Received: by 2002:aa7:c40c:: with SMTP id j12mr11447072edq.80.1567796692440;
 Fri, 06 Sep 2019 12:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-12-pasha.tatashin@soleen.com> <d53d973c-17dc-2f4f-c052-83d6df15b002@arm.com>
In-Reply-To: <d53d973c-17dc-2f4f-c052-83d6df15b002@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 15:04:41 -0400
Message-ID: <CA+CK2bCSDEspfJZ9k_4nWmerQSatc9M_dVf4Jij5xUwTMbg29w@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] arm64, trans_pgd: add PUD_SECT_RDONLY
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:21 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Thre is PMD_SECT_RDONLY that is used in pud_* function which is confusing.
>
> Nit: There
>
> I bet it was equally confusing before before you moved it! Could you do this earlier in
> the series with the rest of the cleanup?
>
> With that,
> Acked-by: James Morse <james.morse@arm.com>

Will move it earlier.

Thank you,
Pasha
