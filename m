Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F313E206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkmbpd8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgAGXqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:46:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44386 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgAGXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:46:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so1361630lje.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQMY8R3LoWt/DsrAqKQp49rhgXtLc3e3mn4wK30Z9bk=;
        b=gkmbpd8bIKIIQEgsb7PEU+2r4ebECX1mH3jgU38dGjJQ8bwXIJG5GKLnoLrnX3Q1Tp
         v1SDB6I1ZXgqhUT4odQ8aVr64tXRhQzQKUJB+gim+8tzuQBIEEgYa0NEh52zxV9MySl4
         8hPqbEMycxVGQOzMT2ZoovSrn2sYCBWsQ2InRnJJnXhziW8CiS8uBVxVuagMUfjKujCp
         HniHcll8yMXWX4ecEITXFam+QamI4BHfLL7Gcvl7S+kf3c4RHt8RoST1Bi3vdrXuETyI
         Kn2nFOF6G8BTDLxmpQhXEOKSQ8HHgKI3g4y9E8Ezgf28cpYXwn+lC6jP8DwKEiXAfN4W
         io5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQMY8R3LoWt/DsrAqKQp49rhgXtLc3e3mn4wK30Z9bk=;
        b=ti9jaMUni3h9qp4EAFrJ+ujNtVniNkVQu3BDyuYNlyPOVtRMiVtuVBAEb9N6LRiFow
         /JnBPsTK2bOkima8g712p1B6Z5is6mcSw7ljQ8NWmmQKiyQZAGY+ykcvTWlB3KOOZEnE
         mbmR9Qiirwvfp3t6/CaeLj9MlxQaJ9zhJiR1x5bQEoot+arzelXLCO+SwPV82p3ejSAc
         E8+u4kdNzAjB5WzP+chdrTN7RmCYrVoQ8V7rySQaHt99irxTGnCS7MAeYtri3UoT8u6v
         Vl0NsoJmSnetOdDkeuTqoUIraCeHiNTp3W3lXIFyL9l5+K5j2WEwZRhZ+Rrs6qJr3xtb
         YffA==
X-Gm-Message-State: APjAAAV59Qd2ttdmD2uE5v+i/WxJMMztDGNRwi/N/Lgm3r3OtAk98tTd
        E5U+ejErfpknUI6cxyZLkgqogjjp0UJhTxsCOIQkqg==
X-Google-Smtp-Source: APXvYqzbmu2DObIlWLfaO9ELFQorRtShpVBsWWzBcZIoobIaBkYXNLSVmLfU7WKSlp/DDnONAcCNR9yJlu88wu2FxpQ=
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr1170522ljk.186.1578440764122;
 Tue, 07 Jan 2020 15:46:04 -0800 (PST)
MIME-Version: 1.0
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
In-Reply-To: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Tue, 7 Jan 2020 15:45:27 -0800
Message-ID: <CAE=gft6sxsZfvPZZXKqbEMjCH_hGKXp_1MS3qTAz6hmMPfn09A@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Split SDM845 interconnect nodes and consolidate
 RPMh support
To:     David Dai <daidavid1@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 9:59 PM David Dai <daidavid1@codeaurora.org> wrote:
>
> While there are no current consumers of the SDM845 interconnect device in
> devicetree, take this opportunity to redefine the interconnect device nodes
> as the previous definitions of using a single child node under the apps_rsc
> device did not accurately capture the description of the hardware.
> The Network-On-Chip (NoC) interconnect devices should be represented in a
> manner akin to QCS404 platforms[1] where there is a separation of NoC devices
> and its RPM/RPMh counterparts.
>
> The bcm-voter devices are representing the RPMh devices that the interconnect
> providers need to communicate with and there can be more than one instance of
> the Bus Clock Manager (BCM) which can live under different instances of Resource
> State Coordinators (RSC). There are display use cases where consumers may need
> to target a different bcm-voter (Some display specific RSC) than the default,
> and there needs to be a way to represent this connection in devicetree.

So for my own understanding, the problem here is that things want to
vote for interconnect bandwidth within a specific RSC context? Where
normally the RSC context is simply "Apps@EL1", we might also have
"Apps@EL3" for trustzone, or in the case we're coding for,
"display-specific RSC context". I guess this context might stay on
even if Apps@EL1 votes are entirely discounted or off? So then would
there be an additional interconnect provider for "display context RSC"
next to apps_bcm_voter? Would that expose all the same nodes as
apps_bcm_voter, or a different set of nodes?

Assuming it's exposing some of the same nodes as apps_bcm_voter, the
other way to do this would be increasing #interconnect-cells, and
putting the RSC context there. Did you choose not to go that way
because nearly all the clients would end up specifying the same thing
of "Apps@EL1"?
