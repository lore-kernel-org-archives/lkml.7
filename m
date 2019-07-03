Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8BCC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754D521882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EVDV2i92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGCV2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:28:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42702 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCV2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:28:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so3893761otn.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Oa5fyrgRSaS4/rlLU6Dg1I751HN6ZGGg3XuTeNEsyA=;
        b=EVDV2i92j6Oc8X9cDYFxw3faBgrvRgokearOh6hTInPcfDEF/9Dw3KaF4Zq6F/M1Po
         7PhktLMJwFP6nTQp9RrenWueYOGk2EVUa/0Qx0+hUltXSvdhvIuEHI+qKgYeF3B1eFlS
         5Y3swajWUyLDnwgyIA3axCIg+XMQUJMGQtIBwCbx1V1d//Itvxh9xcx753a7zTQU7G7q
         9Zf9F4ew3jdtrywY3ZSbzOZTGZe1X8L9mb5LB87Kgaj4vPdRVLpEenwZhPzX+x7S/pLI
         SKnQAFXjTLXqteyTAJ1slhEtrupPHQDbOkd7sNBcRXPLRfHg2/4qMUGQWkb8jOyatu6m
         VoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Oa5fyrgRSaS4/rlLU6Dg1I751HN6ZGGg3XuTeNEsyA=;
        b=pScT8ecWU6krS4ui6HHBG+jQg18ymGven4ciPUOs2OcjkclA+s+TZ6Mo/VkeprncEm
         MTBELp53xSCGQwhEXuAUxHgfdVEELhxZjaqhxWvWxxok6YKne9yCILCpVPyJ/MNBc0NB
         a4LpVxW8DoFBYyw6eQfnAzrW3M4chWETAemIgm0ZcYT5FSLoi77LKSQjapb+fF+SKSVj
         /nrf9XdmWsSj8kxwQDw7ZerIel6o0rkdAemrcm4Sgfod22WFyzzYWQBMoS5dcPUyCKHI
         NmRwo6B0k5ejRM0QDRyS1k4U/xPPvLdI2qQgbuxtYoOTW2UpVjqnHCrqtLlcZ3jkrysu
         wweA==
X-Gm-Message-State: APjAAAUNPn/q1kpMZZeGaC/hBcAa9E2+H5JyfAA1yX3q3KcoKZYnWEUo
        ux6Q8SDaEF7GO04fR/DmkE9/Qfm5UXSFosl7yNUyiw==
X-Google-Smtp-Source: APXvYqx/eeik3ZxIiy7z87X0O8OLG62WiPNdXk3FcnhR2wJoQDPQ4BqLvO7rM7/LGIyRCPcHEmicv2tHJYa45mbHcK0=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr32385007otk.363.1562189332829;
 Wed, 03 Jul 2019 14:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org> <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
In-Reply-To: <20190703195302.GJ1729@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Jul 2019 14:28:41 -0700
Message-ID: <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 03, 2019 at 10:01:37AM -0700, Dan Williams wrote:
> > On Wed, Jul 3, 2019 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> > > > This fix may increase waitqueue contention, but a fix for that is saved
> > > > for a larger rework. In the meantime this fix is suitable for -stable
> > > > backports.
> > >
> > > I think this is too big for what it is; just the two-line patch to stop
> > > incorporating the low bits of the PTE would be more appropriate.
> >
> > Sufficient, yes, "appropriate", not so sure. All those comments about
> > pmd entry size are stale after this change.
>
> But then they'll have to be put back in again.  This seems to be working
> for me, although I doubt I'm actually hitting the edge case that rocksdb
> hits:

Seems to be holding up under testing here, a couple comments...

>
> diff --git a/fs/dax.c b/fs/dax.c
> index 2e48c7ebb973..e77bd6aef10c 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -198,6 +198,10 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
>   * if it did.
>   *
>   * Must be called with the i_pages lock held.
> + *
> + * If the xa_state refers to a larger entry, then it may return a locked
> + * smaller entry (eg a PTE entry) without waiting for the smaller entry
> + * to be unlocked.
>   */
>  static void *get_unlocked_entry(struct xa_state *xas)
>  {
> @@ -211,7 +215,8 @@ static void *get_unlocked_entry(struct xa_state *xas)
>         for (;;) {
>                 entry = xas_find_conflict(xas);
>                 if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> -                               !dax_is_locked(entry))
> +                               !dax_is_locked(entry) ||
> +                               dax_entry_order(entry) < xas_get_order(xas))

Doesn't this potentially allow a locked entry to be returned for a
caller that expects all value entries are unlocked?

>                         return entry;
>
>                 wq = dax_entry_waitqueue(xas, entry, &ewait.key);
> @@ -253,8 +258,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
>
>  static void put_unlocked_entry(struct xa_state *xas, void *entry)
>  {
> -       /* If we were the only waiter woken, wake the next one */
> -       if (entry)
> +       /*
> +        * If we were the only waiter woken, wake the next one.
> +        * Do not wake anybody if the entry is locked; that indicates
> +        * we weren't woken.
> +        */
> +       if (entry && !dax_is_locked(entry))
>                 dax_wake_entry(xas, entry, false);
>  }
>
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 052e06ff4c36..b17289d92af4 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1529,6 +1529,27 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
>  #endif
>  }
>
> +/**
> + * xas_get_order() - Get the order of the entry being operated on.
> + * @xas: XArray operation state.
> + *
> + * Return: The order of the entry.
> + */
> +static inline unsigned int xas_get_order(const struct xa_state *xas)
> +{
> +       unsigned int order = xas->xa_shift;
> +
> +#ifdef CONFIG_XARRAY_MULTI
> +       unsigned int sibs = xas->xa_sibs;
> +
> +       while (sibs) {
> +               order++;
> +               sibs /= 2;
> +       }

Use ilog2() here?
