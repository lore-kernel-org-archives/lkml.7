Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0444C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B662921835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aCtNPlB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLQAI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:08:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43258 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfLQAIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:08:54 -0500
Received: by mail-io1-f68.google.com with SMTP id s2so9003589iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 16:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bb2twKZDh29ThWZYRQTRqA2Jiy4KqbokvVGsd8dKMgg=;
        b=aCtNPlB9aPaMY4cJwRiZed5kiziibm2paiUxxBllsBG7zjS6p8M6aAmbMTh6fpnHhT
         EehB7lZS3uU6T0O9471kbfDFgCM9P35lzdv2mq3W7Lz7j4mzTmWHVC+9WXxAuppWfFfD
         RGHl9tuFssxZ7il/MtuEvgtjLOmQGhJN7CSfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bb2twKZDh29ThWZYRQTRqA2Jiy4KqbokvVGsd8dKMgg=;
        b=tu9KjpZtvNNdffY/0cFu0DHPG7rStFauIFLVRqBKB4aPt/YJX9hGXHoABzUAJH4hej
         r1ReYDvUBT57CWo8gRgfoYpFuNrYcn+JNcPSv4r97z7K3ntIbQMpniID44gYiPkd27/U
         uZg8n2RmAD8zwh7txeOzOXP6kIhVUDo1hYJUp5RctPIpLGdmqIpUBpBOTscOPcufC78C
         jpVg4iq0HrFJuGSMaPD5oxQy0qyGyBoQIonX3+feFDwlhOcevLXnWhAFe+16wn9r+p9i
         1OsZeD+iIChFHGmsxaC2LRjkhfd5T8vEKBkaK7VLeLbOHBy6KRXXZUMhEIsbz65Wcl7X
         srPw==
X-Gm-Message-State: APjAAAV0LSm+7TMu2taJ50MM6T4FNKh7gaDUZ8OOjrithQQU1kigloXW
        JxN69E6isSeCP3oF0TD5RvDY9OmE6sA=
X-Google-Smtp-Source: APXvYqzwqM84TivnDtccyCPenjiSAPs6ldrmLh6jke4bsA//06iJEMflxk4RBRGiNKUyH+AnfO+7nA==
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr1615911ioc.174.1576541333754;
        Mon, 16 Dec 2019 16:08:53 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id q1sm4792556iog.8.2019.12.16.16.08.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 16:08:53 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id g12so6939002ild.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 16:08:53 -0800 (PST)
X-Received: by 2002:a92:da44:: with SMTP id p4mr3406926ilq.168.1576541332664;
 Mon, 16 Dec 2019 16:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20191216234204.190769-1-swboyd@chromium.org>
In-Reply-To: <20191216234204.190769-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Dec 2019 16:08:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VrnMNS6EnGC5DQcPh2GBW+9_h_oqW3pOqqm5DXSkXp6w@mail.gmail.com>
Message-ID: <CAD=FV=VrnMNS6EnGC5DQcPh2GBW+9_h_oqW3pOqqm5DXSkXp6w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-cheza: Add cr50 spi node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 16, 2019 at 3:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add the cr50 device to the spi controller it is attached to. This
> enables /dev/tpm0 and some login things on Cheza.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>
>  - Fixed node name to be tpm
>
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
