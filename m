Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B480C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3FE2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="le6/IjvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfEQRWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:22:15 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33133 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:22:14 -0400
Received: by mail-ed1-f45.google.com with SMTP id n17so11683137edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NWuugkWpQRRWA/1rSmW1lzMgKVNslNjLRYEkdR1Nr8=;
        b=le6/IjvKmu1b5/J+EeSLlKWUQDlzA2Aar3VHLn8ExShqMsFCKjqEBf+toX4TliPE0H
         eb+VONE8jljaQgC23HLZmR5QS5UHQ14s4T0FxyYIFc1hvnC7sseb5WD9AvBCBynEFdA1
         lrQnNndD0CS9PvrNd4djxjYrHkGXrpWHkuZzQhKz2o77NRvXkFxRo3BMupdD9bP4JwDh
         yQuehqXV3ucui8vm8YCOufYwj2Wjwx3CcE2DourDzyTtKv53LPK/Fz1M5PAGRNdsAIKj
         bO3vOu6X06VOTo0XH8SXdjrvrE9azf4qJEek9V7PjsFw50AHNk+SxUWS1jrukw+OJIJ/
         FaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NWuugkWpQRRWA/1rSmW1lzMgKVNslNjLRYEkdR1Nr8=;
        b=KcKarqTw11eOzYJ9CnzMcDR8KPoMlFaoAfwsJj04jwrqQM8o4dYnJp2KHA3yGafBPM
         y2rF6Or4igRaOnmjyKYBR6u3akP3p7ZHQz1HDoAo3uXI8LcTotSi/niY40DqL57deQTS
         aYUuFHnqF52RhIOUslx8duzdphknQdaNNGkybF0MDq//2j354qdOqKD8nYnyFFWORosD
         DisJ65o8DgcPcUsiqk+w7mzyLDZAwyYHCFRTMLzjn2qsD7PaXRYItAZy904p5X8PnAGO
         y3uerECkrVDbC/lrmqwDYTa9rFKd+L6YN6FLLo1bJju94vFZPKmMnT1ihrVhphDflg1x
         ccFg==
X-Gm-Message-State: APjAAAV3a9LvaotLc6gaejrMGRwMRUMlGZRGP36V7go5q6UiFcf9Av4l
        1ZC6ECfba2LJyHMDeDY6GPjpoBwriwj++cnVxd7Wrg==
X-Google-Smtp-Source: APXvYqx8zTScvrcOMIUQcp6YiIXAtTO5C4EC3YusWLTaHpQGKmpnKkByyxWWHYm2mGvPVmZ4pHgwJqvrnr9pIKweO4c=
X-Received: by 2002:a50:f48d:: with SMTP id s13mr59668225edm.151.1558113732961;
 Fri, 17 May 2019 10:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
 <20190517143816.GO6836@dhcp22.suse.cz>
In-Reply-To: <20190517143816.GO6836@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 17 May 2019 13:22:02 -0400
Message-ID: <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
Subject: Re: NULL pointer dereference during memory hotremove
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:38 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> > This panic is unrelated to circular lock issue that I reported in a
> > separate thread, that also happens during memory hotremove.
> >
> > xakep ~/x/linux$ git describe
> > v5.1-12317-ga6a4b66bd8f4
>
> Does this happen on 5.0 as well?

Yes, just reproduced it on 5.0 as well. Unfortunately, I do not have a
script, and have to do it manually, also it does not happen every
time, it happened on 3rd time for me.

Pasha
