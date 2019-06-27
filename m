Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C03C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F16208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh0eEy4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0QCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:02:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34591 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0QCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:02:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3223324wrl.1;
        Thu, 27 Jun 2019 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX0PH5LENMLq4sqsfzVBDZigOo0jYU9ew5cFE8wrzTg=;
        b=Xh0eEy4GNq2E1fFz0Mf4HWpAQzWzv+Mh4oLRb7vSZS98yd6MvlK9CboKxTcwOewaHO
         Y7k7uwsAV/mqnfv4lPq71a6rCgKWf0mciNxHc/aKROYQqo3F7QfHLFBpsmTHsEyYO2mi
         DeZRhmJ84RgySQzi+KhkdTqhOpF/60KlzvaNaT+wnmmfyxx9o9mMAQZRuJ3B7oLjaK0z
         7qGkR4TqhRwg11aXJVXbRwP+c9imC8TXDHVwSKLt3ZT2x22NIX17w3krZPySsSg86iZz
         4RFn4l+ONCVqOh6P/uyGysBZKn3Ns3QSQAS4BOl3KHDqwEIfBp6WlNvvWQGMnMiRESFO
         Bz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX0PH5LENMLq4sqsfzVBDZigOo0jYU9ew5cFE8wrzTg=;
        b=tP2F5DYvkrXNCqnO77D9n9DiE3L8uzYNQvTg1JYCqsis+gJM2JRbTHzKecZDSHOPtd
         R3e3gTEvxK6dnCaB++6KGlyzZXpYg6U7MJSHNiZKxhMPRslEVIWtcicRDZOQ35k4gsPI
         SlHTpahla0BrutOmz0lvPQQe4a8L7pJ0CJElPp/9EDybV36musJzhgUkqQBTSGzm+HsY
         QIWKuJ2NxXJMG585TaTNqHag5NCz5m0qvojvEcpPS1n03gHUSSyUVyxfVtMVYQXVIGEi
         /M/+kXzGO/Wkz2qGtyJRAQs95dizUW08aMUJoCwySnNX/odoNrmsSvsiW5UUb3PBn/g+
         MVmA==
X-Gm-Message-State: APjAAAVsj3AvDcq0OUFYhqo6EVLRnOv4pyKTCoclG+zJZ+zzxjl0E4nc
        xKkBRMGPW7PGgqaYvjdtvWLefG1061oc4ORX8MSDiYzw
X-Google-Smtp-Source: APXvYqyuyR+GwQcgXshLDQQ3dyR5MLZwf3sqxXo+FdDohn6bKxhmN9ZlAtZsWNwu4HWBtHbYKrH5m3umtNSoLetgp1U=
X-Received: by 2002:a05:6000:106:: with SMTP id o6mr4101553wrx.4.1561651331074;
 Thu, 27 Jun 2019 09:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132427.12615-1-colin.king@canonical.com>
 <CAPj87rM9y5Zen5A5KkiCqqUF5m+vAwwtLj-iJrcwFfzMev+Mrw@mail.gmail.com> <2bd65b8f-f278-1000-d9a2-6476fc3a497f@canonical.com>
In-Reply-To: <2bd65b8f-f278-1000-d9a2-6476fc3a497f@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Jun 2019 12:01:58 -0400
Message-ID: <CADnq5_O9oA4PxnqxwTurRbgQ=M2PceiqUpZiCncdaiYmbJsiQA@mail.gmail.com>
Subject: Re: [PATCH][next[ drm/amd/display: fix a couple of spelling mistakes
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Daniel Stone <daniel@fooishbar.org>, Leo Li <sunpeng.li@amd.com>,
        kernel-janitors@vger.kernel.org, Wenjing Liu <Wenjing.Liu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:32 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 26/06/2019 14:25, Daniel Stone wrote:
> > Hi Colin,
> >
> > On Wed, 26 Jun 2019 at 14:24, Colin King <colin.king@canonical.com> wrote:
> >> There are a couple of spelling mistakes in dm_error messages and
> >> a comment. Fix these.
> >
> > Whilst there, you might fix the '[next[' typo in the commit message.
>
> Ugh, fickle fingers. Maybe the upstream devs will fix that before
> applying...

Fixed up and applied.

Thanks,

Alex

>
>
> >
> > Cheers,
> > Daniel
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
