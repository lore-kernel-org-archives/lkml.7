Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC674C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFD82070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="O020jbcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfJCLue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:50:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39792 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:50:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so3105080qtb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4tYmUjoUlo2Xqo/y5um3PxrT1tlXAA1LkGIE6UYEn3o=;
        b=O020jbcrUFhT7KwwXQCB/2LZrgQ+ScGaUJxYQJ/UuGXHx2SvPAyvqKmcIkaW13VAA7
         0QKaEXVjzDGCa867Z/x9JT5clpj3l07TR55z5aY6NMqDYXkRP+KsNuCA22pth51J9uRR
         Q4xOrykegrbfbsZjzuQfdrJEqNqNO6pdllyYbgdDDIO7sajMeLiwLk5dOylA1ZlRVKXk
         dnWiCVIP5y1KM7T2D8ioH6xpVZqtZddeDeGIg1VnZ7B8aytHmivwXZVq2KXEkGzHlBJ5
         ZMYd5vnhGsnCRfRF1M7OLCWex4QYZzn6YSnDMRy2A58jnM5SYCgA9dEp/2GX2YvQEup7
         RwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4tYmUjoUlo2Xqo/y5um3PxrT1tlXAA1LkGIE6UYEn3o=;
        b=uSNCfHZxkHETmgPXqsmCa5al6SFBtGOLtuYovXgk89TTKfnrsE6IWHvgE7vIj8nYdi
         Y39Uh1/G2AjQwgwB3KUShjDcP6DTXxKwmEV0wQX7X8zLHAzPQDhBrGFLJi9M6+vTcOh8
         ovykJ5pHeHl1o5mdO3HSLsEcpKgGZBw8mo2shoOIAMghbAgXuMrJz4niFI2Qe47eOWtb
         0jBNzzPYM1qRODjmAo+/IkczsTjDlkquHeDd9BGh0+wO2mQ0DxJCCNcOUPs4i5BtbrTp
         5ynLO+IMlKs5e2eVs7C94LC423z7hTdN+6rfXL3FYTVzKV7KhM9ORxiv7meoiow09LMZ
         5ylQ==
X-Gm-Message-State: APjAAAWFriCCLWGX5Ylern0HS8MS/b93WYkEWjVIS8EBMtYkrj92mkYu
        iziQ6d6StLgsgjAQYoGMqPsM0Q==
X-Google-Smtp-Source: APXvYqwVwqVvYGwiskRdDpkyuODvgkHB5LyrTXwGoZJb7/HmZY3p+AKlv9WZlAn53Q3l7PTr0EWa/A==
X-Received: by 2002:a0c:8867:: with SMTP id 36mr8044088qvm.177.1570103433376;
        Thu, 03 Oct 2019 04:50:33 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z12sm1464699qkg.97.2019.10.03.04.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 04:50:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in has_unmovable_pages()
Date:   Thu, 3 Oct 2019 07:50:31 -0400
Message-Id: <983E7EA4-A022-448C-B11D-8C10441A2E07@lca.pw>
References: <d3a88afd-63c6-1091-cf4c-75cd10b7f547@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <d3a88afd-63c6-1091-cf4c-75cd10b7f547@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2019, at 7:31 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> w=
rote:
>=20
> Ohh, never meant that the 'Reserved' bit is anything special here but it
> is a reason to make a page unmovable unlike many other flags.

But dump_page() is used everywhere, and it is better to reserve =E2=80=9Crea=
son=E2=80=9D to indicate something more important rather than duplicating th=
e page flags.

Especially, it is trivial enough right now for developers look in the page f=
lags dumping from has_unmovable_pages(), and figure out the exact branching i=
n the code.=
