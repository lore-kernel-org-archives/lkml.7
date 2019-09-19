Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A34F2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV8wtyty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfISO2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:28:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40566 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfISO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:28:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so3244731ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgW2uxCVtaKbF7TbtCGjgw8sygkrT37j0scFhp7VikQ=;
        b=YV8wtytyUcDiMlRw0PwjWtAkaedjNlzX7apKcI4e5g1zDxCjzsX15aAafl5eVAgN5b
         wsomzSUtSlT0+n8KSapRMDX8X+c9btPtAzwA/r8SZvUsoRGUWUBouf7re8WCXVgcrN7t
         7/vBZKlwlI9aQxycGUBGmMaichRriBAciC0yae3aZviR5eIRnmJRUmZS7PkKROPjEXn9
         ZD7mOzxESg2P8dgk0fcBnzxGXbUUhbvs0818cVrYkQl+1Mr3HFyPmlxMAsuDIs50w27t
         G0mExnSsmmrPs7to+eF1TZhMScUo3K1tUx6maP+5isROBNP05Ne+wtVlOhWJVHp7/cD7
         MGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgW2uxCVtaKbF7TbtCGjgw8sygkrT37j0scFhp7VikQ=;
        b=QUNVcCcf6mesC+Sv/QdD9yPJbe+AlYrmfF9fAavoqwRrldZFsKGmuEmqTc1GELDELM
         R4Xn7zGKuHQ5A367luz+VDn4g+x1y2DcJWyd60/yIJa96tStOiP7ODKXb/kL56bqNgYD
         6pzFXnfXGQvUW3bQxbWcj9XBlmWQYy4zOo6hb8GqifUG0OzInh1TPxltzaURpS8vmGss
         qjyAfcNfRSRhWeYkEITH4OFnym++AkWGMAtmZ4J945ckfVMzb2Pjstvgm2/ufU4ztytJ
         QVIy6AQeC7gfQ1IQlK5BzDrQ8HBnnPZSau225/ZqaogZA4geq3T/gVVMHIdqDgvf66wo
         Urzw==
X-Gm-Message-State: APjAAAVRf2UshrTYEh8Z7qK3efGesfSJnMW6nORaAyzjU+5GmxhovjUL
        D/B1dYAjPGnmCCvalaLjM+zf0Uu1ov9neWL4DLE=
X-Google-Smtp-Source: APXvYqx7iOsTDyTC5MOoGe4i38azW0PdixKT3lxKfQTK2hHQYfSpvB84CcTf07+u7MbM/xsPCPUEfFKnSbF07BopLkc=
X-Received: by 2002:a9d:562:: with SMTP id 89mr7354793otw.232.1568903313740;
 Thu, 19 Sep 2019 07:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com> <20190918190529.17298-1-navid.emamdoost@gmail.com>
 <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
In-Reply-To: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 19 Sep 2019 10:28:22 -0400
Message-ID: <CAGngYiWHe1mw0+Ay6HO7kG5y8HMriUX3BO8VUcTvGayEK-4JOw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Thu, Sep 19, 2019 at 4:05 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> > +out4:
> > +     kfree(i2s_pdata);
> > +out3:
> > +     kfree(adev->acp.acp_res);
> > +out2:
> > +     kfree(adev->acp.acp_cell);
> > +out1:
> > +     kfree(adev->acp.acp_genpd);
>
> kfree on a NULL pointer is harmless, so a single error label should be
> sufficient.

That is true, but I notice that the adev structure comes from outside this
driver:

static int acp_hw_init(void *handle)
{
...
struct amdgpu_device *adev = (struct amdgpu_device *)handle;
...
}

As far as I can tell, the init() does not explicitly set these to NULL:
adev->acp.acp_res
adev->acp.acp_cell
adev->acp.acp_genpd

I am assuming that core code sets these to NULL, before calling
acp_hw_init(). But is that guaranteed or simply a happy accident?
Ie. if they are NULL today, are they likely to remain NULL tomorrow?

Because calling kfree() on a stale pointer would be, well
not good. Especially not on an error path, which typically
does not receive much testing, if any.

My apologies if I have misinterpreted this, I am not familiar with
this code base.

Sven
