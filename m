Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194BB22DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr0+4L4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfICVma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:42:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33284 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:42:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so423673ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BE22rdpGi0wj7EdpVjb4I26895Qlqc0EPZOEPPFnqZo=;
        b=pr0+4L4tXZKc3JFEDLzqAuzNkEU+eT3ZMdCa+GLkHKvWHop1oZuC3E06bnwvKkck1K
         A+H8W2OkRAKOWg5kXs8/UXRl47Cy0vte71lA+B3XGTdnqAqOAJXtQrIWXPH1GvqFocEM
         /g6t2giGYIPyplxKwitHuEcX7eF3c5UL/p0x4KimiOcc7AauAgWWQ28JtZNYkTdGzK96
         jkPYTcaGI1Wvme3qUbbsrWx7XCljWeyxjvFKq5zfqCe1sCITwPUiA5+2aaU9OcbtNc5V
         si35Ip6/glndUW84qWWIyjC9zEEInds/62VywYgdLJK+Ys1alXfDZZvO8Jk4sOq2qH3+
         PzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BE22rdpGi0wj7EdpVjb4I26895Qlqc0EPZOEPPFnqZo=;
        b=k8GlD9QBaollgcsDTG7pqkHf+05+d+aM9km1tJ3S7Hy7bem7hlrUR/yOaN+lXpPfJh
         cH5v1hjfSAGHsE7mUKFe7SvclYzlig/XDqO0KMBwZeLlaJYs7YJOlqIRBcs/kbMn+tHa
         EywuGcOIwFUoQaj49MT16odf4d9dwXRW+8UvC5qwuERpGLt03j41sB9iFPQpaZIXVIss
         YPefv7B/pMhYj35DtUqSBM7WzwKYjZXokNY6PgS1D8R5GYyJ+aBvjPGyhOwnaXOfP0S8
         JAaUs7PQ+g4+TX2ZWzq4Z+gC9TGxTqTqAWNcZqCOFwZSPYYUQvQdur2qQ7t1WjVyczPK
         hKhA==
X-Gm-Message-State: APjAAAX8jLlvxzgxjtXHnVFzTPGUgxlysG9Ar23F13pddph3lta3AwdE
        5Qd1hCm0y5QlwqHvlp1qFS6p7q5GGigc2matuV0=
X-Google-Smtp-Source: APXvYqzAMS9MZNAZGHChQ9oaIQKvzlBk9um2dNn1JwEC3QyBkv82BbGYL5E8ee1wZ6MWmqxI/zMHjvg4hK/ofe2+P3Y=
X-Received: by 2002:a2e:8658:: with SMTP id i24mr19669320ljj.188.1567546947949;
 Tue, 03 Sep 2019 14:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-16-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-16-lyude@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 4 Sep 2019 07:42:16 +1000
Message-ID: <CAPM=9ty-264nFotVRy7VwMw_BQPo-=7su7y3J2MjC9Sdkxcu+A@mail.gmail.com>
Subject: Re: [PATCH v2 15/27] drm/dp_mst: Cleanup drm_dp_send_link_address() a bit
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Juston Li <juston.li@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <hwentlan@amd.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 06:48, Lyude Paul <lyude@redhat.com> wrote:
>
> Declare local pointer to the drm_dp_link_address_ack_reply struct
> instead of constantly dereferencing it through the union in
> txmsg->reply. Then, invert the order of conditionals so we don't have to
> do the bulk of the work inside them, and can wrap lines even less. Then
> finally, rearrange variable declarations a bit.
>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
