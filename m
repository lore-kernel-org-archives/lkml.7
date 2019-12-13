Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD9C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1982465B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576230440;
	bh=IKEdrsSKJblOibK5fe0H4I2W7nC4YKk1IrBD2NRgP1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uwto26H5k5p49ZTCUKE7aZwHwtinCNjIv6Uts1SvPj9+xrH05/+ubJwUcj448zuXR
	 5pIFwT4M3q6zb8KyT+ppAuPNUncRVI8KtdQ4uNRMlLax6RwQt/oD3XrqEpa2hzIG79
	 vKIiIm3qpzNg0EAgaROaKcDRDBeOZlh0raGFoKgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:47:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44861 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:47:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so5714433oto.11;
        Fri, 13 Dec 2019 01:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrgOuy/9sPvzhX64/ManuYWOHaw5/qKpeJcMH1l0dJw=;
        b=ucbY6U5i8iqwKIzDam7juPFkESzPvu0Nt8Zw7vbAfvrJ0Y2MmuE5qnHyZjzKko8KGT
         9bmH+IGTMX2gWt5jCkhhaJ8CCu2aRNSoWZ6obh3YBKkaRe0/KQIFVaffpZvDH/pok2pg
         wdjzY0HL2qZ/XyjBXmm3prMfc+axkzjgPc0mba2RCUhsgPx931WfO+wk2MKf9HeyVPK7
         yKB7xkmF28LtidaMUskmSe29l8CdGEk15l4/tBREkWhgMU2FCZDX01Ra31D83J1Lcgu4
         nbDhuryen6RtncKNk+zsK7JA2uEfQZLr6dD5qunPw0q3mS7JxiUBSggi3Au7yicia2U5
         tB+Q==
X-Gm-Message-State: APjAAAXaDJOH97oLfFTRPfA2v9KHkxRTwmC4dZhvG2HjdSj1bu8iTKR7
        4iENu6jUfaHFdUsicfXG4KXlmJx/jIkzPBP/pkE=
X-Google-Smtp-Source: APXvYqyTYrRZu/3wd+jVnsU9fJlU3qWbi4XDyl6SoSVPdfbCj6mQh4LJVDI5doZGlsmV/j5Q03mkCLX7+C1j0mvjiyg=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr13098278ote.118.1576230438826;
 Fri, 13 Dec 2019 01:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20191212171137.13872-1-david@redhat.com> <20191212171137.13872-2-david@redhat.com>
 <5687328.t4MNS9KDDX@kreacher> <ec81db03-b970-420a-9c1b-29849b5e8902@redhat.com>
In-Reply-To: <ec81db03-b970-420a-9c1b-29849b5e8902@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Dec 2019 10:47:07 +0100
Message-ID: <CAJZ5v0iqgnhOF1UQQBfv7C_b5RyoAz=U3JYLt3a0U+UnZ48DUA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/13] ACPI: NUMA: export pxm_to_node
To:     David Hildenbrand <david@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        kvm-devel <kvm@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:41 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.12.19 22:43, Rafael J. Wysocki wrote:
> > On Thursday, December 12, 2019 6:11:25 PM CET David Hildenbrand wrote:
> >> Will be needed by virtio-mem to identify the node from a pxm.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  drivers/acpi/numa/srat.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> >> index eadbf90e65d1..d5847fa7ac69 100644
> >> --- a/drivers/acpi/numa/srat.c
> >> +++ b/drivers/acpi/numa/srat.c
> >> @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
> >>              return NUMA_NO_NODE;
> >>      return pxm_to_node_map[pxm];
> >>  }
> >> +EXPORT_SYMBOL(pxm_to_node);
> >>
> >>  int node_to_pxm(int node)
> >>  {
> >>
> >
> > This is fine by me FWIW.
>
> Can I count that as an Acked-by and carry it along? Thanks!

Yes, please.
