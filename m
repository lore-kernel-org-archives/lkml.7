Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39BBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F7E20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554701756;
	bh=P6M025d1Zgt9X/PmaXvAYtoClYp36sFXXpyaKIL5RhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ozSjho48VP2YO1Z/jFx2EEJ2E/ayMB0pNWbjq2mHUZkNv8wQjtV8I6TLjcu3hyA4N
	 BdSIaa0sxtPMXOwWgVPVevJHRRz69D8nI4EcJalm1XYoNQHAxYNwP/zZ8pAD7nkQx6
	 NeCIRk/1Nh33rT67GvpztKxWmbUIvkB4CId+ZC+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfDHFfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:35:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41492 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHFfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:35:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so8457462lfr.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+SMtvytlSiOc/cu6kg/i2uCYQdbjbuO3DZI99pciYU=;
        b=UM8jkNe3FivfjyjKQt0KIK00yEWIPKwCaxAzwPUf0x8n60fbSIe7PJodQN4uaQVDns
         2bDMJFFS6cD4Izl7uwOyaFlSvkFQ/2MiQxr23R+3qgHyeiIoZWHrQlBibOhl6rOOls/+
         FbEE0DkGCt2IM9u0wMFd7IOX0s6PcR3lvtyWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+SMtvytlSiOc/cu6kg/i2uCYQdbjbuO3DZI99pciYU=;
        b=Hmx9mjLm9KW3HReLqp/3ZM6IN3SpDwlhoCwjq+5Upyqr53l64oxGetMV/yBkOPkbKM
         /1BHgh5M/QJCkisPoubX9mouXKVihwydl7dBL/aqXK/UDTplF2TmF/+lZOH6TjVVTnQn
         UVcXuxzpKk6B+mfpduF8DvL7yHCOZzkZkegpUmKhxNXfdDJfjYC8SYTL0m7ydl11qH5x
         XilHwmK1cUjkJgOYDr6XFhUPk+FoKp5pYRp+6O32kdscupr2RITjDD59fU+p5Iw4KiSP
         fREglvvwthwGx4GpmxuxUfMWSq25R/D6kdkSrXPs1bahNgVOfllazFnuWhm2N0Bp44/X
         0qwA==
X-Gm-Message-State: APjAAAUTMWqGWJPA7ES0qxQTVDifk9ZqgfI0Y7onndzS4/05PDL758kN
        FslKRhJgdSau1NROnGuTJHLahOEfDnQ=
X-Google-Smtp-Source: APXvYqzUJzDeTMCvCiu2bbqqRFLGJFR36wEe9c1tnOEUzkDyis2EJppieXXiBgDooTKzeN5kQUm2Mw==
X-Received: by 2002:ac2:5581:: with SMTP id v1mr13726508lfg.92.1554701752018;
        Sun, 07 Apr 2019 22:35:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f15sm6270187ljm.47.2019.04.07.22.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:35:50 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m13so8469315lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:35:50 -0700 (PDT)
X-Received: by 2002:a19:f512:: with SMTP id j18mr9036020lfb.48.1554701750359;
 Sun, 07 Apr 2019 22:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190406225901.35465-1-cai@lca.pw>
In-Reply-To: <20190406225901.35465-1-cai@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Apr 2019 19:35:34 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
Message-ID: <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
Subject: Re: [PATCH] slab: fix a crash by reading /proc/slab_allocators
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Tejun Heo <tj@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 12:59 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit 510ded33e075 ("slab: implement slab_root_caches list")
> changes the name of the list node within "struct kmem_cache" from
> "list" to "root_caches_node", but leaks_show() still use the "list"
> which causes a crash when reading /proc/slab_allocators.

The patch does seem to be correct, and I have applied it.

However, it does strike me that apparently this wasn't caught for two
years. Which makes me wonder whether we should (once again) discuss
just removing SLAB entirely, or at least removing the
/proc/slab_allocators file. Apparently it has never been used in the
last two years. At some point a "this can't have worked if  anybody
ever tried to use it" situation means that the code should likely be
excised.

Qian, how did you end up noticing and debugging this?

                 Linus
