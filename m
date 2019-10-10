Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6ECC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C547220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570721542;
	bh=OCbNHp9XfcUM0QmcYZHuxvuZ72tVMIWV5NkzlJUXnf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vh1ReFI5cC5/90P26ODVn6iBfjCrnvnclv0eJzRQpCGMfg9r8157Uu2a8dW7X7qjp
	 2iHIse4nC9BPYE71UIBzxXuo0rJRVyWACWlIv44MiXdiwp7tDTZqPoUqfAaTYOvyNV
	 fyz+Kw8FS0HhL8z6p+YJ3oIF2lJkF9g/WqWyFClY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfJJPcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:32:21 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E338E20B7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570721541;
        bh=OCbNHp9XfcUM0QmcYZHuxvuZ72tVMIWV5NkzlJUXnf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nHVklzU1lmcKAHuGh682Tq/tEEzBngD2WqvYJqJr7e4qIvJg1BX+gBZgdqqPWMH5f
         qJgvNTw/UJT6GKgfZIqF0duoSeK+X8hMiQA4tzIQ0rxN6MaDu9wQfYcfGU9HYGF4KB
         iIVLMM6CpdQSoU0lwlicUbBsLkgjoftACQGyj35E=
Received: by mail-yb1-f174.google.com with SMTP id 206so2068841ybc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:32:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVm9Gj2AbxGie1Wav5+RcL3ez3AV7sF3wV1xMhaFyH2hPw8rblB
        8xA32eoECeF8da6m9veAQLGbwVjXsAQ7zj9fug==
X-Google-Smtp-Source: APXvYqzEPhAkVCbQQjjzo3IU4PJ7Pf1s3lEphJMuRfUgT2YpW+iGwzGZuhEIh3L+n8n4IVIq7CX9WAYQbFh77rEa5+A=
X-Received: by 2002:a25:c883:: with SMTP id y125mr6956870ybf.358.1570721540132;
 Thu, 10 Oct 2019 08:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191008194155.4810-1-robh@kernel.org> <fd2f61bb-1ff8-f90b-9514-e662db2ff19f@epam.com>
 <362d1eac-e352-d8de-1b6f-586acc0007ce@oracle.com>
In-Reply-To: <362d1eac-e352-d8de-1b6f-586acc0007ce@oracle.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Oct 2019 10:32:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+OajTgKoV2gWQCfGbE32LNp23tjgOpTTLcwLx19jBU9A@mail.gmail.com>
Message-ID: <CAL_Jsq+OajTgKoV2gWQCfGbE32LNp23tjgOpTTLcwLx19jBU9A@mail.gmail.com>
Subject: Re: [PATCH v2] xen: Stop abusing DT of_dma_configure API
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 9:00 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 10/9/19 7:42 AM, Oleksandr Andrushchenko wrote:
> > On 10/8/19 10:41 PM, Rob Herring wrote:
> >> As the removed comments say, these aren't DT based devices.
> >> of_dma_configure() is going to stop allowing a NULL DT node and calling
> >> it will no longer work.
> >>
> >> The comment is also now out of date as of commit 9ab91e7c5c51 ("arm64:
> >> default to the direct mapping in get_arch_dma_ops"). Direct mapping
> >> is now the default rather than dma_dummy_ops.
> >>
> >> According to Stefano and Oleksandr, the only other part needed is
> >> setting the DMA masks and there's no reason to restrict the masks to
> >> 32-bits. So set the masks to 64 bits.
> >>
> >> Cc: Robin Murphy <robin.murphy@arm.com>
> >> Cc: Julien Grall <julien.grall@arm.com>
> >> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >> Cc: Juergen Gross <jgross@suse.com>
> >> Cc: Stefano Stabellini <sstabellini@kernel.org>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Cc: xen-devel@lists.xenproject.org
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> > Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
>
> Is this going to go via drm tree or should I pick it up for Xen tree?

Please apply to the Xen tree.

Rob
