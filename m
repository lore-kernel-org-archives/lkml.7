Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA1CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A321473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="F85MjR0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfFNS55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:57:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43330 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfFNS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:57:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so2698988oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY348vpCG95iTNSMF3TDF4pbwXas3ck/kElwYiwrsvw=;
        b=F85MjR0gN90YTSSPhCUn9lf3+gAUAMWR5V9MYVfBOrCJQ1H3hiLjul2ugj7VnpOTBa
         i9Sp+K18uEQofN4tumrHUXaqcMNxTu6cGGZm6yttT/JpXMgr1xATwuYNtg+gZXBCVGhv
         +mT01bZVNXo9pF/l9GffY/mlArCMf2aa3APCyIJWkZmcBddGaH8yofAJhPmyebNaOItK
         N8sIZN8LJ3WJtxM2h/reyObc1JIGEWlLWAB5zVkxh/YE/W9nGbnxAAcfvDIFMf4k5Cqq
         x5e4uXA4P1jBGWyObYdHmdFkNCTlR8nUiUTvIRg4KrDsp+lPH7/kprCmsmkBnMQBnyoi
         M7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY348vpCG95iTNSMF3TDF4pbwXas3ck/kElwYiwrsvw=;
        b=aN+e18zH2zy6vD5UD7m5nH5rbRGq9t0XaAejI2D0+4fUS3JrJ7gtM0FrIPiIiEugTD
         D0dNX/pXLM9GOI87+6TORyQV7AYzybICe2IWUBMOOMQA4Np0DX/4xj1WiMRLsgFpXsZZ
         S3SIE9RW5SjVTY68nkN9lvZH4hNxSp0zFE60bAgZC/DNBEUyf4Sou40+8V8xMKfRCllF
         N0m3yPD7SAMSI3wdWxHUxPIy9jvWCZ8zDMMPxK8DaI8Q+ifGXoupx8DYSh1mLi/6ei+X
         gulVeCBmQfxxt4wZ9s9sVz3ADSF5uJxr32503P9AiEiI8IL4mMj8DG3/fDaBsWqKCtx8
         d2kw==
X-Gm-Message-State: APjAAAUWH+dTZW83q7djYpXQO2tuG5QVnhxkJz7JGzzh58S4rCTu7fPw
        fdueQmVn4cJq2U6pgaQFxcV56yKRtpbQKwKIinZPrg==
X-Google-Smtp-Source: APXvYqzdJjEMIV2pl920MqFFLoWETfGaqo1sZN3VwAO8LaYfKv/sIYkMWWbQLkGsWPRjVz6yQawZkMZ47z54qwd7laI=
X-Received: by 2002:aca:4208:: with SMTP id p8mr2892814oia.105.1560538675845;
 Fri, 14 Jun 2019 11:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
 <1560524365.5154.21.camel@lca.pw> <CAPcyv4jAzMzFjSD22VU9Csw+kgGbf8r=XHbdJYzgL_uH_GVEvw@mail.gmail.com>
In-Reply-To: <CAPcyv4jAzMzFjSD22VU9Csw+kgGbf8r=XHbdJYzgL_uH_GVEvw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Jun 2019 11:57:44 -0700
Message-ID: <CAPcyv4hjvBPDYKpp2Gns3-cc2AQ0AVS1nLk-K3fwXeRUvvzQLg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006edde2058b4d3902"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006edde2058b4d3902
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 14, 2019 at 11:03 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 14, 2019 at 7:59 AM Qian Cai <cai@lca.pw> wrote:
> >
> > On Fri, 2019-06-14 at 14:28 +0530, Aneesh Kumar K.V wrote:
> > > Qian Cai <cai@lca.pw> writes:
> > >
> > >
> > > > 1) offline is busted [1]. It looks like test_pages_in_a_zone() missed the
> > > > same
> > > > pfn_section_valid() check.
> > > >
> > > > 2) powerpc booting is generating endless warnings [2]. In
> > > > vmemmap_populated() at
> > > > arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
> > > > PAGES_PER_SUBSECTION, but it alone seems not enough.
> > > >
> > >
> > > Can you check with this change on ppc64.  I haven't reviewed this series yet.
> > > I did limited testing with change . Before merging this I need to go
> > > through the full series again. The vmemmap poplulate on ppc64 needs to
> > > handle two translation mode (hash and radix). With respect to vmemap
> > > hash doesn't setup a translation in the linux page table. Hence we need
> > > to make sure we don't try to setup a mapping for a range which is
> > > arleady convered by an existing mapping.
> >
> > It works fine.
>
> Strange... it would only change behavior if valid_section() is true
> when pfn_valid() is not or vice versa. They "should" be identical
> because subsection-size == section-size on PowerPC, at least with the
> current definition of SUBSECTION_SHIFT. I suspect maybe
> free_area_init_nodes() is too late to call subsection_map_init() for
> PowerPC.

Can you give the attached incremental patch a try? This will break
support for doing sub-section hot-add in a section that was only
partially populated early at init, but that can be repaired later in
the series. First things first, don't regress.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 874eb22d22e4..520c83aa0fec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7286,12 +7286,10 @@ void __init free_area_init_nodes(unsigned long
*max_zone_pfn)

        /* Print out the early node map */
        pr_info("Early memory node ranges\n");
-       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
                pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
                        (u64)start_pfn << PAGE_SHIFT,
                        ((u64)end_pfn << PAGE_SHIFT) - 1);
-               subsection_map_init(start_pfn, end_pfn - start_pfn);
-       }

        /* Initialise every node */
        mminit_verify_pageflags_layout();
diff --git a/mm/sparse.c b/mm/sparse.c
index 0baa2e55cfdd..bca8e6fa72d2 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -533,6 +533,7 @@ static void __init sparse_init_nid(int nid,
unsigned long pnum_begin,
                }
                check_usemap_section_nr(nid, usage);
                sparse_init_one_section(__nr_to_section(pnum), pnum,
map, usage);
+               subsection_map_init(section_nr_to_pfn(pnum), PAGES_PER_SECTION);
                usage = (void *) usage + mem_section_usage_size();
        }
        sparse_buffer_fini();

--0000000000006edde2058b4d3902
Content-Type: text/x-patch; charset="US-ASCII"; name="fix.patch"
Content-Disposition: attachment; filename="fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jwwgclts0>
X-Attachment-Id: f_jwwgclts0

ZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxsb2MuYwppbmRleCA4NzRl
YjIyZDIyZTQuLjUyMGM4M2FhMGZlYyAxMDA2NDQKLS0tIGEvbW0vcGFnZV9hbGxvYy5jCisrKyBi
L21tL3BhZ2VfYWxsb2MuYwpAQCAtNzI4NiwxMiArNzI4NiwxMCBAQCB2b2lkIF9faW5pdCBmcmVl
X2FyZWFfaW5pdF9ub2Rlcyh1bnNpZ25lZCBsb25nICptYXhfem9uZV9wZm4pCiAKIAkvKiBQcmlu
dCBvdXQgdGhlIGVhcmx5IG5vZGUgbWFwICovCiAJcHJfaW5mbygiRWFybHkgbWVtb3J5IG5vZGUg
cmFuZ2VzXG4iKTsKLQlmb3JfZWFjaF9tZW1fcGZuX3JhbmdlKGksIE1BWF9OVU1OT0RFUywgJnN0
YXJ0X3BmbiwgJmVuZF9wZm4sICZuaWQpIHsKKwlmb3JfZWFjaF9tZW1fcGZuX3JhbmdlKGksIE1B
WF9OVU1OT0RFUywgJnN0YXJ0X3BmbiwgJmVuZF9wZm4sICZuaWQpCiAJCXByX2luZm8oIiAgbm9k
ZSAlM2Q6IFttZW0gJSMwMThMeC0lIzAxOEx4XVxuIiwgbmlkLAogCQkJKHU2NClzdGFydF9wZm4g
PDwgUEFHRV9TSElGVCwKIAkJCSgodTY0KWVuZF9wZm4gPDwgUEFHRV9TSElGVCkgLSAxKTsKLQkJ
c3Vic2VjdGlvbl9tYXBfaW5pdChzdGFydF9wZm4sIGVuZF9wZm4gLSBzdGFydF9wZm4pOwotCX0K
IAogCS8qIEluaXRpYWxpc2UgZXZlcnkgbm9kZSAqLwogCW1taW5pdF92ZXJpZnlfcGFnZWZsYWdz
X2xheW91dCgpOwpkaWZmIC0tZ2l0IGEvbW0vc3BhcnNlLmMgYi9tbS9zcGFyc2UuYwppbmRleCAw
YmFhMmU1NWNmZGQuLmJjYThlNmZhNzJkMiAxMDA2NDQKLS0tIGEvbW0vc3BhcnNlLmMKKysrIGIv
bW0vc3BhcnNlLmMKQEAgLTUzMyw2ICs1MzMsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc3BhcnNl
X2luaXRfbmlkKGludCBuaWQsIHVuc2lnbmVkIGxvbmcgcG51bV9iZWdpbiwKIAkJfQogCQljaGVj
a191c2VtYXBfc2VjdGlvbl9ucihuaWQsIHVzYWdlKTsKIAkJc3BhcnNlX2luaXRfb25lX3NlY3Rp
b24oX19ucl90b19zZWN0aW9uKHBudW0pLCBwbnVtLCBtYXAsIHVzYWdlKTsKKwkJc3Vic2VjdGlv
bl9tYXBfaW5pdChzZWN0aW9uX25yX3RvX3BmbihwbnVtKSwgUEFHRVNfUEVSX1NFQ1RJT04pOwog
CQl1c2FnZSA9ICh2b2lkICopIHVzYWdlICsgbWVtX3NlY3Rpb25fdXNhZ2Vfc2l6ZSgpOwogCX0K
IAlzcGFyc2VfYnVmZmVyX2ZpbmkoKTsK
--0000000000006edde2058b4d3902--
