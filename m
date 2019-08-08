Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC080217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd/6MShz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfHHFcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:32:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35002 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfHHFcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:32:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so1072966wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnFHzRjF2xpQkvpgxIv833AGZ8y7ivoh6PhkIV/Ft14=;
        b=bd/6MShzzpiecQAhFBAuSWXr5ibrQqhz9pYZ4qECaGNwmne2qCZAuyO20gkWEm7Alt
         9R2w4z9i3gomswnz8J3IcEq4kvirvItHH6XoRzIayj07nB1imdDu236PAuvOq43GY3J6
         jpYQs11Tn6g4wVWexHUCg7mZx+8eDqlTJZx5CU+DMqN7Imsf4d5LjGXcNvco/H2p/EW4
         6mbZCbXj6mmGIy5LwnHlxNCQmv2qVfLJQv8MY7z9e40453R5C0lqqnUK+KhJPPni4q9j
         cTFnBTQs9zY+GTiDq8qFKYo8rMVaG2lWHSCyQEufd+AiKI1TEDwEVoETgJuob4BMl5k+
         D2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnFHzRjF2xpQkvpgxIv833AGZ8y7ivoh6PhkIV/Ft14=;
        b=qS9+67CIbB/VUxTEASnk7L8Mm5c9/Zx+PoZoKAM0Jari4ga3iKmIqHqK0hVgUAM+dl
         DxDLif5R8b04ab3TDxP+mEScHAsVgz9KcAYdAh7svbk3bgG5IQEx0vL/BUd/4wzeP5M+
         lVA7vG/2qwW2r2DITrq+191BbhWmIT50soCiSGXakwWK8LCWh2b2UPLV0p1xlgLlOwMi
         HxjXCBEn+NFSZOj35CXD52wAhjUFTtsGdk68Du7ux7BpBY5XSQpuwaFtew/wSgqAsvXn
         vFZidA8QLuOPNX6zX06ponwj2sBmMbVzIW+QFxKjFSoYUs6WdFwMwUm+CCfWv+myx5I0
         Y6zg==
X-Gm-Message-State: APjAAAUkG+Qlq1tZHhsd88ZsILu4mc7O+DG1bn1Kpa/1WbGPvaDbWjda
        GIS7jo773jTUHOvp5qczKORv+2taIRzrK+J+9V8=
X-Google-Smtp-Source: APXvYqzW+HFnOuJ9Z79OuqJC6DbO9RKLaFVy/c8lavnL0WaspOeHTZHPqSe3R46tKRBIfsisfMpapeNQUHITCyKt2KM=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr2011547wmk.127.1565242322005;
 Wed, 07 Aug 2019 22:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190806014830.7424-1-hdanton@sina.com> <CABXGCsMRGRpd9AoJdvZqdpqCP3QzVGzfDPiX=PzVys6QFBLAvA@mail.gmail.com>
In-Reply-To: <CABXGCsMRGRpd9AoJdvZqdpqCP3QzVGzfDPiX=PzVys6QFBLAvA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Aug 2019 01:31:50 -0400
Message-ID: <CADnq5_O08v3_NUZ_zUZJFYwv_tUY7TFFz2GGudqgWEX6nh5LFA@mail.gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit here)
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>, Dave Airlie <airlied@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="00000000000097c52f058f94601e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000097c52f058f94601e
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 7, 2019 at 11:49 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, 6 Aug 2019 at 06:48, Hillf Danton <hdanton@sina.com> wrote:
> >
> > My bad, respin with one header file added.
> >
> > Hillf
> > -----8<---
> >
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -23,6 +23,7 @@
> >   */
> >
> >  #include <linux/slab.h>
> > +#include <linux/mm.h>
> >
> >  #include "dm_services.h"
> >
> > @@ -1174,8 +1175,12 @@ struct dc_state *dc_create_state(struct
> >         struct dc_state *context = kzalloc(sizeof(struct dc_state),
> >                                            GFP_KERNEL);
> >
> > -       if (!context)
> > -               return NULL;
> > +       if (!context) {
> > +               context = kvzalloc(sizeof(struct dc_state),
> > +                                          GFP_KERNEL);
> > +               if (!context)
> > +                       return NULL;
> > +       }
> >         /* Each context must have their own instance of VBA and in order to
> >          * initialize and obtain IP and SOC the base DML instance from DC is
> >          * initially copied into every context
> > @@ -1195,8 +1200,13 @@ struct dc_state *dc_copy_state(struct dc
> >         struct dc_state *new_ctx = kmemdup(src_ctx,
> >                         sizeof(struct dc_state), GFP_KERNEL);
> >
> > -       if (!new_ctx)
> > -               return NULL;
> > +       if (!new_ctx) {
> > +               new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
> > +               if (new_ctx)
> > +                       *new_ctx = *src_ctx;
> > +               else
> > +                       return NULL;
> > +       }
> >
> >         for (i = 0; i < MAX_PIPES; i++) {
> >                         struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
> > @@ -1230,7 +1240,7 @@ static void dc_state_free(struct kref *k
> >  {
> >         struct dc_state *context = container_of(kref, struct dc_state, refcount);
> >         dc_resource_state_destruct(context);
> > -       kfree(context);
> > +       kvfree(context);
> >  }
> >
> >  void dc_release_state(struct dc_state *context)
> > --
> >
>
> Unfortunately error "gnome-shell: page allocation failure: order:4,
> mode:0x40cc0(GFP_KERNEL|__GFP_COMP),
> nodemask=(null),cpuset=/,mems_allowed=0" still happens even with
> applying this patch.

I think we can just drop the kmalloc altogether.  How about this patch?

Alex

>
> Thanks.
>
>
> --
> Best Regards,
> Mike Gavrilov.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000097c52f058f94601e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amd-display-use-kvmalloc-for-dc_state.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-use-kvmalloc-for-dc_state.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz28unhl0>
X-Attachment-Id: f_jz28unhl0

RnJvbSBjM2JhNmYwNWNhM2UwMzcxMjU0ZmJmYjFhOGMwNjI3NGUzY2RiOTZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgOCBBdWcgMjAxOSAwMDoyOToyMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWQvZGlzcGxheTogdXNlIGt2bWFsbG9jIGZvciBkY19zdGF0ZQoKSXQncyBsYXJnZSBh
bmQgZG9lc24ndCBuZWVkIGNvbnRpZ3VvdXMgbWVtb3J5LgoKU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCA5ICsrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGMuYwppbmRleCAyNTJiNjIxZDkzYTkuLmVmNzgwYTRlNDg0YSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC0yMyw2ICsyMyw3IEBACiAgKi8K
IAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC9tbS5oPgogCiAjaW5j
bHVkZSAiZG1fc2VydmljZXMuaCIKIApAQCAtMTE4Myw4ICsxMTg0LDggQEAgYm9vbCBkY19wb3N0
X3VwZGF0ZV9zdXJmYWNlc190b19zdHJlYW0oc3RydWN0IGRjICpkYykKIAogc3RydWN0IGRjX3N0
YXRlICpkY19jcmVhdGVfc3RhdGUoc3RydWN0IGRjICpkYykKIHsKLQlzdHJ1Y3QgZGNfc3RhdGUg
KmNvbnRleHQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgZGNfc3RhdGUpLAotCQkJCQkgICBHRlBf
S0VSTkVMKTsKKwlzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQgPSBrdnphbGxvYyhzaXplb2Yoc3Ry
dWN0IGRjX3N0YXRlKSwKKwkJCQkJICAgIEdGUF9LRVJORUwpOwogCiAJaWYgKCFjb250ZXh0KQog
CQlyZXR1cm4gTlVMTDsKQEAgLTEyMDQsMTEgKzEyMDUsMTEgQEAgc3RydWN0IGRjX3N0YXRlICpk
Y19jcmVhdGVfc3RhdGUoc3RydWN0IGRjICpkYykKIHN0cnVjdCBkY19zdGF0ZSAqZGNfY29weV9z
dGF0ZShzdHJ1Y3QgZGNfc3RhdGUgKnNyY19jdHgpCiB7CiAJaW50IGksIGo7Ci0Jc3RydWN0IGRj
X3N0YXRlICpuZXdfY3R4ID0ga21lbWR1cChzcmNfY3R4LAotCQkJc2l6ZW9mKHN0cnVjdCBkY19z
dGF0ZSksIEdGUF9LRVJORUwpOworCXN0cnVjdCBkY19zdGF0ZSAqbmV3X2N0eCA9IGt2bWFsbG9j
KHNpemVvZihzdHJ1Y3QgZGNfc3RhdGUpLCBHRlBfS0VSTkVMKTsKIAogCWlmICghbmV3X2N0eCkK
IAkJcmV0dXJuIE5VTEw7CisJbWVtY3B5KG5ld19jdHgsIHNyY19jdHgsIHNpemVvZihzdHJ1Y3Qg
ZGNfc3RhdGUpKTsKIAogCWZvciAoaSA9IDA7IGkgPCBNQVhfUElQRVM7IGkrKykgewogCQkJc3Ry
dWN0IHBpcGVfY3R4ICpjdXJfcGlwZSA9ICZuZXdfY3R4LT5yZXNfY3R4LnBpcGVfY3R4W2ldOwot
LSAKMi4yMC4xCgo=
--00000000000097c52f058f94601e--
