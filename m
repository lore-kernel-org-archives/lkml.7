Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B920C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EDB2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Xg6OGbjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfDXUdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:33:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44066 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfDXUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:33:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id i13so17121308edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ei50cL/3SAzu+3HwY4Rcgwlyq29ejpdQ2HpVb/S/D9s=;
        b=Xg6OGbjcfyaLCpDFhcTnpTO0iMfD/817X5nad/yjtudZp5QywW5weHOdb9geKQ7fX1
         ajO0Auw6e7a4gakil7TmM47F5054UAHeVoyNPrkYi+mNkbiGhzoVnTy1MynMu+Wt68Tf
         ULl93eCOPa3lJ4pns7KmMESX420Hf7IZC7uVPgB2WAsPleGBaRmWciy10fbmrvie4EK6
         Jr3BmDrWGQQcIYj8C6hYyk/5B6ISkKIdFBT1Mca66lY2iEViy9Rctii5QifP2/JpbyIw
         DUdETDpUjrFDaCsYEPKNAo08kyX6zXVxe1ANGYqmSy4C8EsKxZ9RQtakVGdSkEPfqqkL
         +Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ei50cL/3SAzu+3HwY4Rcgwlyq29ejpdQ2HpVb/S/D9s=;
        b=uYGwlU+1k5jrZb2ahXKlOOZtDHa4jyrynCXOlhu52cJ2RHt4GXvjWXPUrSYVAuISrL
         QNadHVwqL3QyLjPz2aDRaNUZSfi38g7QcF0DnowZM5Mc9SOdZbd7vqeScDzoAG6edNXj
         tUQB1gID6gjVrSHiJQFLnCkM6xm6xh1zAy6WdH+TsmMtaXjhUMoLyu92WrkJQZh8oXi2
         1eSKTJlODD0eG32E1NZaGVwzGopaMmnXvtiV5Jn9hkhPNrNqEDf8vF+e5qThNmtzq2Uq
         JcbBoKP5RKa8WjfChedCbSFdWvGRAGXg2pLB4sJKAA7FsCChKTUuILas3NXVQjTKgd6r
         GciA==
X-Gm-Message-State: APjAAAXUkhAma7L3rgHeu7sUUTMYWdH5aVgGmURit5zi/ERgJNGKeXD+
        OPyQXmoar9ruqmqTsikyxTcs0PAUvOd0EdtcBHFdQg==
X-Google-Smtp-Source: APXvYqxagCAaBl5kqo4ujsFeZlClVv7V6IZGrmsI+2EHtCmYLQuoHtSZQewi6mFo2fEG0MV854NdLjtX1+fNETp2fVs=
X-Received: by 2002:a50:89cd:: with SMTP id h13mr20624076edh.79.1556138001745;
 Wed, 24 Apr 2019 13:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
 <7f7499bd-8d48-945b-6d69-60685a02c8da@arm.com> <CA+CK2bCD11x64pJj5gSnsu5jsUqJyU6o+=J4K8oYAsHqz9ULqQ@mail.gmail.com>
 <CA+CK2bB5ahqLrekkTUSdzTE2BPSPbB9nk6nKs+LjTap2oF8X-w@mail.gmail.com> <CAPcyv4gdo5GcS8cbvLQr0Ez09z32VyrbVouW2GVV5UJf8R3HWw@mail.gmail.com>
In-Reply-To: <CAPcyv4gdo5GcS8cbvLQr0Ez09z32VyrbVouW2GVV5UJf8R3HWw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 24 Apr 2019 16:33:10 -0400
Message-ID: <CA+CK2bC7iEsg8Fdep6kphNTNroCi_zi1ejApspSZyTq_VFvxOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: configurable sparsemem section size
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, rppt@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, sboyd@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is yet another example of where we need to break down the section
> alignment requirement for arch_add_memory().
>
> https://lore.kernel.org/lkml/155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com/

Hi Dan,

Yes, that is exactly what I am trying to solve with this patch. I will
test if your series works with ARM64, and if does not I will let you
know what is broken. But, I think, this patch is not needed if your
patches are accepted into mainline.

Thank you,
Pasha
