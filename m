Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F54C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC040208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140338;
	bh=UhiqMVHtV0dLej7SP9g439uVAff58P9Irl4SOTUoetc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gHtq/a8R7yUy+9SenmCfK0ElaWmOn0Rml6OAHFuWA+T5XtacFPREBr/Bgzkzdu3EV
	 ABithANcUh1MTpusunybpIJrFMSv5gvnoRLIh7+kMwLcfXCp+oc4UDHlPQVgrWHUmD
	 Nd7i1dA/Cb5gGjC6CDwcqBNNCS9CON2Ue8QMotEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfFUSFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:05:36 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:46688 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:05:36 -0400
Received: by mail-lf1-f49.google.com with SMTP id z15so5655310lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkYyL67CNGYKGgM9r7dwT8ZYE4U7QkyC3ItCF9X1hcM=;
        b=dv9Qvp8QX5IP5eCfEA74EyTjANkLhGHdTL6idhmn93L0PLv8UwhQOuZJyDSXIiXMh0
         G0QjXxaba0bumx+9KOJcvCd/6/ze7+24mK+uCLBNVeMWatUp1oCVLbji7XZmgbxa9FJ8
         d1fgYMD4EFaoGpXyrtOJAaQwtVZjUFNJSGv6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkYyL67CNGYKGgM9r7dwT8ZYE4U7QkyC3ItCF9X1hcM=;
        b=JYLtvorOYYDzSY00saW/qvoG6eoUjnCo7/269fr3HxFEbDZ5qz07s4YQf88UMmPecN
         gCEhaKDlqpc/lxtp4dbCYOe3CuJyPD2jlvZW8MaLyhuiBa0PZLMro6YkHWiDFBCigyQh
         S0S5fLXfgz3RgrboZLtCdgwFJWlqJd12FGcO9/Thk53mTCHAL2TgPUaV0reZKKrz7NCC
         RgCMf2u2hYYRXWLyg7ZJ1nO3X3FStkDEo6O4ILa3G/PWNDKIVP79+OTk9uKYZoNMpAq6
         UbCFqEJlgaxKGcoeQb5h5j+TRQ/JpY0evWPS8VC0hcg6L/0zfB4Y4ntJwn4B9kcJ9IYh
         Q9hA==
X-Gm-Message-State: APjAAAWWUrLTvyIPF8DdrIQVuIJvJ28ptId7VQN5mOlUJH9nG2FQ2+2X
        lBZ2zDbuoSujOoFSMqlp6iM1y6akfhY=
X-Google-Smtp-Source: APXvYqyWg8mZCIS1Xse7Ypbio7jrUjvl01rzRReKGqd4JyOM16nWCK3kYQi8XuiAjWcc+CxpiALCEw==
X-Received: by 2002:a19:750b:: with SMTP id y11mr31738050lfe.16.1561140333664;
        Fri, 21 Jun 2019 11:05:33 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l29sm477974lfp.83.2019.06.21.11.05.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 11:05:32 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v18so6744001ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:05:32 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr10076233ljm.180.1561140332237;
 Fri, 21 Jun 2019 11:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
 <CAHk-=wifNAnkd+bXfoNWXO1K5NQ8Tr+Hc13SgaBXU3RoQB7Pwg@mail.gmail.com> <CAPj87rP451duPWi4TQjcqzbyVKYp_v7=ibwR=2UnQyWttLDWNg@mail.gmail.com>
In-Reply-To: <CAPj87rP451duPWi4TQjcqzbyVKYp_v7=ibwR=2UnQyWttLDWNg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Jun 2019 11:05:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih2mBygBvVru4QLbBHEO_5C5yLwbE8qL47Fzj3A1m6vA@mail.gmail.com>
Message-ID: <CAHk-=wih2mBygBvVru4QLbBHEO_5C5yLwbE8qL47Fzj3A1m6vA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.2-rc6
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:06 AM Daniel Stone <daniel@fooishbar.org> wrote:
>
> > Does it work for you? I'm getting a connection reset, no data.
>
> It is quite sick indeed; it's fallen down an NFS hole and is being
> restarted. Should be back in a few minutes.

Thanks,  everything does indeed look good again now,

                 Linus
