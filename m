Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50791C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160982146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfYKBa3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBDl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:41:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46603 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBDl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:41:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so15721701ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 20:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwFMvNlDZyc812vrg+bp/ViMSNpSgttyG5YsRP7U/zs=;
        b=mfYKBa3Fe+hxUiDN022gH0lEGTEMq3JXVnwiUnLyW6FqMu7SRaHkzGumur2mcma+i3
         p0RofUHDm3aCF+7v7SRVceN74CHTceHz7LgkcmbYg3hmSireatVhaTiKBHNk3muKza5C
         KNIrfHTCeFuL07S2xdESCkaeQy+DDBVXD6UKvHj0rGw+yrt9Wjyn7eaKZHjDPQg7ykr1
         iNxuu/kAR/Fxr9Agl85nh5t39bo4SpthylP2XjKGz+CJtH6wO1d1iSAg1kbMyMRfOQ9C
         zkeKZi0gxjbXGgYU7a9ZhKjmWxzPuggcWw2JJp7MkXF9s4pj00IbtYMJsu5LjNMMpl59
         mEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwFMvNlDZyc812vrg+bp/ViMSNpSgttyG5YsRP7U/zs=;
        b=ebIeDDsSMiXxmShffvDdPteYQhzAEMOMTpMfKhEzyShg9nlKT23vZnnLD/0FrN0vd9
         musGEfYhBPSm1+MUcZRtAZysvZWJvRANDzcEepwalZpHnttcVu8pGkQBrg56bALTuMJ7
         X31w2+q10AzZ6NA7xE0ikfAPmS/5Q3T7442p2aryCFJUU9DtZLH94KAazukQeCXqEDOX
         yDFD0ZcQm02uaprLDBO6Cxbb+pSDICSMZy+3zmAS7DfCfsVxQE9IFJGE0q/Pypm6kxoy
         M9ACiEw+As40THFDih9KVQ3TS/pyOe7i+xDhPBku45kTnTpLJm+skKWgCn7RzpasyfS6
         uNCg==
X-Gm-Message-State: APjAAAWrjAjImV7EFpP2kQ0J02iuDZprWLvkMSqrnUIaLhAHx8w6hS9g
        bSz3jxv/e+lci4DbSOSuw0bruRuCfPJJcydGaeDS0w==
X-Google-Smtp-Source: APXvYqzaTQmQ+2ZZdku7sIVKLWcpaRAB4YyGNBeZcAlNsV3Vt05L27tpBfdujxcXoF6JYx6GEVFUFZr3VLm6h/L6d5A=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr24058948otr.231.1562038886315;
 Mon, 01 Jul 2019 20:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <20190702004811.136450-5-saravanak@google.com>
 <CAL_JsqKAn2uD4DC2wqJtkqLTFJ54yG_qaQjgfg=YrQfSEhJw+g@mail.gmail.com>
In-Reply-To: <CAL_JsqKAn2uD4DC2wqJtkqLTFJ54yG_qaQjgfg=YrQfSEhJw+g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Jul 2019 20:40:50 -0700
Message-ID: <CAGETcx8_rXX+PJUq6JqMVquejg_T9rrbCCCP62p4XtSbV2EUYw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] driver core: Add edit_links() callback for drivers
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:46 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 1, 2019 at 6:48 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > The driver core/bus adding dependencies by default makes sure that
> > suppliers don't sync the hardware state with software state before all the
> > consumers have their drivers loaded (if they are modules) and are probed.
> >
> > However, when the bus incorrectly adds dependencies that it shouldn't have
> > added, the devices might never probe.
> >
> > For example, if device-C is a consumer of device-S and they have phandles
> > to each other in DT, the following could happen:
> >
> > 1.  Device-S get added first.
> > 2.  The bus add_links() callback will (incorrectly) try to link it as
> >     a consumer of device-C.
> > 3.  Since device-C isn't present, device-S will be put in
> >     "waiting-for-supplier" list.
> > 4.  Device-C gets added next.
> > 5.  All devices in "waiting-for-supplier" list are retried for linking.
> > 6.  Device-S gets linked as consumer to Device-C.
> > 7.  The bus add_links() callback will (correctly) try to link it as
> >     a consumer of device-S.
> > 8.  This isn't allowed because it would create a cyclic device links.
> >
> > So neither devices will get probed since the supplier is dependent on a
> > consumer that'll never probe (because it can't get resources from the
> > supplier).
> >
> > Without this patch, things stay in this broken state. However, with this
> > patch, the execution will continue like this:
> >
> > 9.  Device-C's driver is loaded.
> > 10. Device-C's driver removes Device-S as a consumer of Device-C.
> > 11. Device-C's driver adds Device-C as a consumer of Device-S.
> > 12. Device-S probes.
> > 13. Device-S sync_state() isn't called because Device-C hasn't probed yet.
> > 14. Device-C probes.
> > 15. Device-S's sync_state() callback is called.
>
> We already have some DT unittests around platform devices. It would be
> nice to extend them to demonstrate this problem. Could be a follow-up
> patch though.
>
> In the case a driver hasn't been updated, couldn't the driver core
> just remove all the links of C to S and S to C so that progress can be
> made and we retain the status quo of what we have today?

The problem is knowing which of those links to delete and when.

If a link between S and C fails, how do we know and keep track of
which of the other 100 links in the system are causing a cycle? It can
get unwieldy real quick. We could delete all the links to fall back to
status quo, but how do we tell at what point in time we can delete
them all?

> That would
> lessen the chances of breaking platforms and reduce the immediate need
> to fix them.

Which is why I think we need to have a commandline/config option to
turn this series on. Keep in mind that once this patch is merged, the
API for the supplier drivers would be the same whether the feature is
enabled or not. They just fallback to status quo behavior (do their
stuff in late_initcall_sync() like they do today).

This patch series has a huge impact on the behavior and I don't think
there's a sound reason to force it on everyone right away. This is
something that needs incremental changes to bring in more and more
platforms/drivers into the new scheme. At a minimum Qualcomm seems
pretty interested in using this to solve their "when do I change/turn
off this clock/interconnect after boot?" question.

-Saravana
