Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06857C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F472147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VPnaqtSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCLXYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:24:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43271 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfCLXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:24:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id g7so43086lfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MonfYzUYTd7rr22db8jefFyNv9cfFsE8AZVDDvGtm5w=;
        b=VPnaqtSUGjjZa3rRP/Ekm503vfyVihd6JR0lWGKIicpMYtympQ0FtlAbeBPGuULEAD
         yTk8n4x4B1jnbe5p+GHVFFcKkQcuBAzmC/rdRZbx3BMBAekam/F8wL0ke+yPwOqL3W5h
         C/7hAo+hQF7dCWBeBtwTObXL7Jl1hQkJmsp+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MonfYzUYTd7rr22db8jefFyNv9cfFsE8AZVDDvGtm5w=;
        b=ezhZY1Cga+/p7QvyfzITHP13hkTSuc9dZ73/Lk3fTWC7AhW+qaXDPIpHojCBShys2H
         Nlnhy8VR+MyMSOg2TG/UT55zPstO6RC1/IG23/RS9N4NlqK2Hs7uEJ2PC+316m3poqd4
         QmWVNxIQjOr033PKOdpPn7LQzBqf9IDAVWQjp2LWKz1KZ4+NUUZX6xBsPw3V/zurfN3D
         lav3rYoQDtrm1UtF36KDmgMdj7IyWhliVrMtSjPaZ7a/4unkc9LH63Eml8kZiPCyU28s
         7FbXTP/gBy1N/rrhb7nl8PYWxvQbLdIAn1Qjk4mvZmLmtVA7cNYlrStOdzZuT5pFIKzg
         vZbw==
X-Gm-Message-State: APjAAAUJJSex3dN89NqIswKMxYbDi+BSXdfyNycPKrhoyIrpU0YK+VE9
        WzDSZzGasJ8cS4mZo8DWJRfq3CbgDx8=
X-Google-Smtp-Source: APXvYqwqJGdgi+zF+iinYWL8MP15b1Wnu1F1djC1vb/T09o/yqTvuh0Ee9miBc75bwPcosEaOCcUfA==
X-Received: by 2002:a19:8c1e:: with SMTP id o30mr11981489lfd.137.1552433087963;
        Tue, 12 Mar 2019 16:24:47 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k21sm1988104lfg.90.2019.03.12.16.24.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 16:24:47 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w6so3847843ljd.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:24:47 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr21718949ljj.30.1552433086637;
 Tue, 12 Mar 2019 16:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190311140602.12160-1-georgi.djakov@linaro.org>
In-Reply-To: <20190311140602.12160-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 12 Mar 2019 16:24:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft57bX_CeDJdb=aFUkGBoODLdXipgtHqNWV_-KdpYmXvfg@mail.gmail.com>
Message-ID: <CAE=gft57bX_CeDJdb=aFUkGBoODLdXipgtHqNWV_-KdpYmXvfg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Include the interconnect resources DT header
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        daidavid1@codeaurora.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 7:06 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Include the device tree header for the on-chip interconnect endpoint
> resources on sdm845 devices. This will allow using the "interconnects"
> property in DT nodes to describe the interconnect path resources they use.
>
> The sdm845 interconnect provider DT node is already present, but the
> header file with the resources is not included, so let's fix this.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
