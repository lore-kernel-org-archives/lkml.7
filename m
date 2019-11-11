Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB843C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB8C214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="n6pipo/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKKXij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:38:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35893 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKXij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:38:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id j7so13129164oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Je0ZHWOZ2BYPwu3RBQEhmnYKnwtQzjlQ/fRKdAJeE0=;
        b=n6pipo/jXtxIMwwDDb0G7uOF3sUaQpbnwzvN4VwrgnmX2npSflOiNj4eTQklfK8yGr
         UEtJEA+ym9HMzyhMRQqZee/nMBU1jZcqaP1JAynpxKac6y2ywNrh7WYsPgSMPFNk6IPS
         KtmxFIEH4NwWjqrS/fIClOqQ0stA9FySbQqh6RIRcHFtoSr2U8pt7vvninOoUx7gopnL
         mxys2gFipifhwQyfwyZL31tvuEzp7t/JJ77RciRCEcHmu8JW1xcm4oQ0awmMgvO1+ExK
         gvroIXNjroxQcj1YHEapR7OvVbU7SgCUtQP7Dcj/eQGzGI2J/XSZ2vMXwLWYuzpa5Fpp
         z45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Je0ZHWOZ2BYPwu3RBQEhmnYKnwtQzjlQ/fRKdAJeE0=;
        b=Gb1KTaUP94TTKUyqDe1xBaTjIad+4+e7YWUM2wgS3QEsGU8FOJAfRp4ZIrhbHuoxNR
         II7DUaCzdRkcoAugzqVkSYbRLXjKluhJCi4OeIZ071Wk4OQpxuiQDSACtk+TDJ4a57i7
         En0c0/t3UOt+b2aqNIMH94NNNcrewjYs4rvuLy/VFHncWW/1zKCuhhUgOUtNbqvZriBM
         Cxh4cC0T/o6xJmHU5Qsl+8sv/isAnzACvu7kRilx4bUB3Afb3HMjzZpNNOayuxblhaTX
         GSnkvWdyuQTlHdox/2dmEXz0yqpnXpmvZL9aZXjTIzw6R8B6FYHOaj6GVMhZRUgNFmQp
         /ehg==
X-Gm-Message-State: APjAAAVn5Qi/tGFRy0uoWVt7DwqoN/0FhNajXez2VNzECcCPku/37LeX
        9t5PhwV5U4Vj6Lbi+GTehOkttMX5BartJzwbfwpsI6gl
X-Google-Smtp-Source: APXvYqxbZsJ10V6w2wbRLO2yReepeG/YOZZdYR2sRldcmu5tb3vyid9/nPtAaX9cvPrYo9Vbgae2nzHJH34Hm79jWOQ=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr1304656oia.70.1573515517596;
 Mon, 11 Nov 2019 15:38:37 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309906694.1582359.4777838043061104635.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87v9rq8xb5.fsf@linux.ibm.com>
In-Reply-To: <87v9rq8xb5.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Nov 2019 15:38:26 -0800
Message-ID: <CAPcyv4jbRNo3A-Utsjt6N-iubR8z_NMxPSWeeGZhr3-gjmMC9A@mail.gmail.com>
Subject: Re: [PATCH 13/16] acpi/mm: Up-level "map to online node" functionality
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 3:39 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The acpi_map_pxm_to_online_node() helper is used to find the closest
> > online node to a given proximity domain. This is used to map devices in
> > a proximity domain with no online memory or cpus to the closest online
> > node and populate a device's 'numa_node' property. The numa_node
> > property allows applications to be migrated "close" to a resource.
> >
> > In preparation for providing a generic facility to optionally map an
> > address range to its closest online node, or the node the range would
> > represent were it to be onlined (target_node), up-level the core of
> > acpi_map_pxm_to_online_node() to a generic mm/numa helper.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/acpi/numa.c  |   41 -----------------------------------------
> >  include/linux/acpi.h |   23 ++++++++++++++++++++++-
> >  include/linux/numa.h |    2 ++
> >  mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
> >  4 files changed, 54 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index eadbf90e65d1..47b4969d9b93 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
> >  }
> >  EXPORT_SYMBOL(acpi_map_pxm_to_node);
> >
> > -/**
> > - * acpi_map_pxm_to_online_node - Map proximity ID to online node
> > - * @pxm: ACPI proximity ID
> > - *
> > - * This is similar to acpi_map_pxm_to_node(), but always returns an online
> > - * node.  When the mapped node from a given proximity ID is offline, it
> > - * looks up the node distance table and returns the nearest online node.
> > - *
> > - * ACPI device drivers, which are called after the NUMA initialization has
> > - * completed in the kernel, can call this interface to obtain their device
> > - * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> > - * offline nodes.  A node may be offline when a device proximity ID is
> > - * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> > - * "numa=off" on x86.
> > - */
> > -int acpi_map_pxm_to_online_node(int pxm)
> > -{
> > -     int node, min_node;
> > -
> > -     node = acpi_map_pxm_to_node(pxm);
> > -
> > -     if (node == NUMA_NO_NODE)
> > -             node = 0;
> > -
> > -     min_node = node;
> > -     if (!node_online(node)) {
> > -             int min_dist = INT_MAX, dist, n;
> > -
> > -             for_each_online_node(n) {
> > -                     dist = node_distance(node, n);
> > -                     if (dist < min_dist) {
> > -                             min_dist = dist;
> > -                             min_node = n;
> > -                     }
> > -             }
> > -     }
> > -
> > -     return min_node;
> > -}
> > -EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
> > -
> >  static void __init
> >  acpi_table_print_srat_entry(struct acpi_subtable_header *header)
> >  {
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 8b4e516bac00..aeedd09f2f71 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
> >  extern bool acpi_osi_is_win8(void);
> >
> >  #ifdef CONFIG_ACPI_NUMA
> > -int acpi_map_pxm_to_online_node(int pxm);
> >  int acpi_map_pxm_to_node(int pxm);
> >  int acpi_get_node(acpi_handle handle);
> > +
> > +/**
> > + * acpi_map_pxm_to_online_node - Map proximity ID to online node
> > + * @pxm: ACPI proximity ID
> > + *
> > + * This is similar to acpi_map_pxm_to_node(), but always returns an online
> > + * node.  When the mapped node from a given proximity ID is offline, it
> > + * looks up the node distance table and returns the nearest online node.
> > + *
> > + * ACPI device drivers, which are called after the NUMA initialization has
> > + * completed in the kernel, can call this interface to obtain their device
> > + * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> > + * offline nodes.  A node may be offline when a device proximity ID is
> > + * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> > + * "numa=off" on x86.
> > + */
> > +static inline int acpi_map_pxm_to_online_node(int pxm)
> > +{
> > +     int node = acpi_map_pxm_to_node(pxm);
> > +
> > +     return numa_map_to_online_node(node);
> > +}
> >  #else
> >  static inline int acpi_map_pxm_to_online_node(int pxm)
> >  {
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 110b0e5d0fb0..4fd80f42be43 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -13,4 +13,6 @@
> >
> >  #define      NUMA_NO_NODE    (-1)
> >
> > +int numa_map_to_online_node(int node);
> > +
> >  #endif /* _LINUX_NUMA_H */
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4ae967bcf954..e2d8dd21ce9d 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
> >
> >  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> >
> > +/**
> > + * numa_map_to_online_node - Find closest online node
> > + * @nid: Node id to start the search
> > + *
> > + * Lookup the next closest node by distance if @nid is not online.
> > + */
> > +int numa_map_to_online_node(int node)
> > +{
> > +     int min_node;
> > +
> > +     if (node == NUMA_NO_NODE)
> > +             node = 0;
>
> The ppc64 variant papr_scm_node return the NUMA_NO_NODE in this case.
> Most of the mm helpers can handle with that value . So instead of
> forcing node = 0, let the subsystem decide what to do with the
> NUMA_NO_NODE value.?
>
> > +
> > +     min_node = node;
> > +     if (!node_online(node)) {
> > +             int min_dist = INT_MAX, dist, n;
> > +
> > +             for_each_online_node(n) {
> > +                     dist = node_distance(node, n);
> > +                     if (dist < min_dist) {
> > +                             min_dist = dist;
> > +                             min_node = n;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return min_node;
> > +}
> > +EXPORT_SYMBOL_GPL(numa_map_to_online_node);
> > +
> >  struct mempolicy *get_task_policy(struct task_struct *p)
> >  {
> >       struct mempolicy *pol = p->mempolicy;
>
>
> Can we also switch papr_scm_node to numa_map_to_online_node()?

Sure, I'll take a look.

May I ask for a review of patches 1-12? Should be quick as they're
mostly following the same theme.
