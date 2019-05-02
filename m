Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B2AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F562085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvZDTO/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEBVPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:15:37 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38632 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEBVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:15:36 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so5948052itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOv6I9+ls0pg/L2LNTaF96Fgd3up03vC2d8X1+k10Jw=;
        b=uvZDTO/qh64JrJcIkvq/4aiOSsw8Q0MsZnjxBm9sZiYPEaSC5Np2Wo1GcTWOQ+u8ua
         hEMRKpS2KWAT3dnc3mJ3W9x2c9zrMfEah06LjsvZRIS9oHkvyrz4dGYO+j6NO4y9sztq
         rGRFCDcUMjr7K+5d1OTLG/+y+Z6/P/J7FfyCY33gvI76Z1EtA9kLA6Qr3Ah5xSafeD7L
         rn90/7Oxfc+zVew4pqQSP65HE62lJBgDMgHtLFYubHCLfWV/2UhQkeKD5y30/kj4jVQ2
         g44lf9J8i86iUBu7OAM6W70hfxqdfPARM1zJthsfCLvd5Y7aW2lpcfVvLz6dF7bM0plU
         16Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOv6I9+ls0pg/L2LNTaF96Fgd3up03vC2d8X1+k10Jw=;
        b=BKMX9+YOHUNp7A+WcBBiTOos8QOxo8MmRmT1jwMDuIHcF8hC+fsZoUmUkkRGM2klgE
         U7gIpCXumMq5Y9lAv+RFEIYHelHShf95T+hsbdUWe3pUQEQKwHdnSYLiaOJWFevCdk7A
         ScZzPsnyHyoyE88UcDMChgp9m8498+bFHWJPgXZEn+1p51i9O5C2qDiCNJFLbyIAMXoy
         bWlgCV6VfgUtA24befkitZ4tXkunefEnASp9FzMjNve7eO789Nq3wc++5Dbp5KyXO+wR
         l58Lpx77V84GLU323Z/CYiqUGY3Bf0d5FFtGN6EiP+scWaI5LrTUOgvMHpc5h6Jw32BB
         8jxQ==
X-Gm-Message-State: APjAAAVaRIBSdb8e1jIiMdepk11cEsVz3KzUsDRLt7Ca3KW+5JzxHsV3
        1s1txQjihCW0eRrkwQkBN9bd+wWrHhU7plKAemS8ag==
X-Google-Smtp-Source: APXvYqzfwJniKNWcSzyn9xHnDRujlzoA6z9dBIzSGvJjoxZ4tSKU0QrYgIKizaFoffmvIPBtAp6YQAp4PV525jIfHOw=
X-Received: by 2002:a24:eb04:: with SMTP id h4mr4550431itj.16.1556831734903;
 Thu, 02 May 2019 14:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com> <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
 <alpine.LRH.2.21.1905030653480.32502@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905030653480.32502@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 May 2019 14:15:23 -0700
Message-ID: <CACdnJuusGU2DMXaPAjH3+QOcSj-9q6njbxxG-9s2PweDKognvw@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 2:07 PM James Morris <jmorris@namei.org> wrote:
> One possible direction is to (as previously mentioned) assign IDs to each
> callsite and be able to check this ID against a simple policy array
> (allow/deny).  The default policy choices could be reduced to 'all' or
> 'none' during kconfig, and allow a custom policy to be loaded later if
> desired.

Ok. My primary concern around this is that it's very difficult to use
correctly in anything other than the "all" or "none" modes. If a new
kernel feature is added with integrated lockdown support, if an admin
is simply setting the flags of things they wish to block then this
will be left enabled - and may violate the admin's expectations around
integrity. On the other hand, if an admin is simply setting the flags
of things they wish to permit, then adding lockdown support to an
existing kernel feature may result in that feature suddenly being
disabled, which may also violate the admin's expectations around the
flags providing a stable set of behaviour.

Given that, would you prefer such a policy expression to look like?

> Within the policy check hook, we could add a new LSM hook, which would
> allow an LSM to restrictively override the lockdown policy with its own

Ok, that makes sense. If we take this approach, does there need to be
a separate policy mechanism at all? Users who want fine-grained
control would be able to set the behaviour to "None" and then use
their choice of LSM to express more fine-grained control.

> This doesn't really address the completeness / maintenance issue (i.e. "do
> we have everything covered and how do we ensure this on an ongoing
> basis?", and "what will this new lockdown feature break?"), although it
> should make it easier to add new lockdown callsites as they don't have to
> be enabled by the user.

I can start on this.
