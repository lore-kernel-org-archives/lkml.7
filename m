Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C097C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE1021019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkjYqCrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfEIQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:47:26 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:44570 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:47:26 -0400
Received: by mail-ua1-f49.google.com with SMTP id p13so1035333uaa.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOD9m5ani8ZrZtUR06eegEmPqO4qUZMEv0GTuqKapM0=;
        b=kkjYqCrQ5OGG+/hCecsHd/H7hfbb1ksW7F69CkE1T1fE/5SY4riNBHew4FB6VanXBT
         0q34uNp/dmGT6m+bSTfegYUWOf+aomEL0P+nmoAMfj7VrtIzqqhT/mYv9AWZPbe/LuJR
         8/tOJXs83BhT+kiebbDIUIoO5crI7NtpvWyTj6KBh7EBuf0ZV7vPJSwQftIYiGY+XxEy
         ONdbfoYirAiggeNSGVmQq7Ab7YIrv7JEOHQ1o9QNkSZ1hnAXnfzSNj1typ+mnA63ouoo
         e9i/zpLln4H5BtdPaqcvRDQC3RpJ2YGKaK4RH/AjZ4YVVaRKqxjFTPna9oCcbuq4Oocp
         U3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOD9m5ani8ZrZtUR06eegEmPqO4qUZMEv0GTuqKapM0=;
        b=avFJsUCwXPkhr0UYiN1OXffdcuzRoRTA8+p5KqL6+olNW4Lu/Tz46dAs859iWUS2pz
         XrE09/h12F7yrkCd7AIPyj69LtqZXooGgKcQhmlHi98S045hwHq/bO4qV/2M1KBceI0C
         EHv16BWsVEG5CZkPaeRtljI7+lLQNgs89s//axaEu3wWoGBap64fHTztUdK1Czeo6F9A
         n3TfHw4ZzBuhOYxEr6CRRs7p/NNbz3vZ7Q8QCjLm9kMSttk4esFvtHURkjA6176rABb8
         6FaQicBL3maX+VbAF06xS8l2kqXKMLE1bgaFHYLxA4nGEWgnlOCCSC8ev/FrQ/RTmcS8
         5C4Q==
X-Gm-Message-State: APjAAAXYfx7AZDRnToo8RE+Y53+4odm7KE9Tl4oXX2yfI7RicqhcTT+m
        6WIuuzfhhn2z74n6DezWQ0Fvc6K+B19ypuiUzZbmfgdr
X-Google-Smtp-Source: APXvYqzIZa4LzmjuxILdnDq1vkqq826kSC1u+DR9Z3NyiMKZfQXFRoCQ354oIVUkTTl9N6h7IJPL5vktO9I0O4rujQI=
X-Received: by 2002:ab0:1410:: with SMTP id b16mr1999491uae.1.1557420445101;
 Thu, 09 May 2019 09:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo57s_ZxmxjmRrCSwaqQzzO5r0SadzMhseeb9X0t0mOwJZA@mail.gmail.com>
 <11029.1556774479@turing-police> <CACDBo54xXk-68MTsxw2K12gD0eGO0Xpq0rw60E3AX+2OEi3igw@mail.gmail.com>
 <26e83e08-3249-e73f-2049-f36b44af8d8a@suse.cz>
In-Reply-To: <26e83e08-3249-e73f-2049-f36b44af8d8a@suse.cz>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Thu, 9 May 2019 22:17:14 +0530
Message-ID: <CACDBo56LBKsxqsHAi=Jd6ZJoZsSpFJ5a_DbwEx9h+=FJjr0rhw@mail.gmail.com>
Subject: Re: Page Allocation Failure and Page allocation stalls
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernelnewbies@kernelnewbies.org, Michal Hocko <mhocko@kernel.org>,
        minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 2:35 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 5/3/19 7:44 PM, Pankaj Suryawanshi wrote:
> >> First possibility that comes to mind is that a usermodehelper got launched, and
> >> it then tried to fork with a very large active process image.  Do we have any
> >> clues what was going on?  Did a device get hotplugged?
> >
> > Yes,The system is android and it tries to allocate memory for video
> > player from CMA reserved memory using custom octl call for dma apis.
>
> The stacktrace doesn't look like a CMA allocation though. That would be
> doing alloc_contig_range(), not kmalloc(). Could be some CMA area setup
> issue?
>
I know cma uses alloc_contig_range() but using dma api it will uses
many functions.
the failure is coming from dma_common_contiguous_remap() for kmalloc ,
and which is called by dma_alloc_attr for cma allocation.

Please let me know, how to avoid page allocation stalls. any reason ?
Cpu Utilization issue ? or I am running out of memory ?

My System configuration is
2GB RAM
Memory Spilt 2G/2G
vmalloc=1024M
CMA=1024
Max contiguous memory required 390M

> > Please let me know how to overcome this issues, or how to reduce
> > fragmentation of memory so that higher order allocation get suuceed ?
> >
> > Thanks
> >
>
