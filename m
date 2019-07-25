Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB08C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6D322BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy8pfw/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfGYPnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:43:52 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38811 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbfGYPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:43:51 -0400
Received: by mail-yw1-f67.google.com with SMTP id f187so19386872ywa.5;
        Thu, 25 Jul 2019 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8u5tRtb2phALqFhx/N87c7RhwGYwIkCOlt6V+GWL8A=;
        b=Yy8pfw/e7Rs8ai1udRsDDUjLgCb54tXT6y666uRoXningJ6b16Hfe4gPkFc5YCAq9m
         ZhuJwie5gNx1vuOcfoAQlOxcCKmpVDoRNfeuHBAGyMjTHBGbz3NdXrcUgwS3Ow+XwiEn
         q/ZTxO0NxWsrxibT7wxe8d6X3zuBiPWgJx5ezArl5AD3X3pnKKY4oVUvP8Vw4HrOSMqG
         d/nAtPI0qr8qniTlqo9JTp4KBgn6Pl4UGlYFII3i83nBs/SPNRQ1ibfDlSsisW8hRKjz
         P7m7VistXF1q7JPo00Q4xy8xKLwgzL6u/4lxgBtgHR0nV4a4HtOqHcb1x6oJv14rue6I
         momA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8u5tRtb2phALqFhx/N87c7RhwGYwIkCOlt6V+GWL8A=;
        b=r4OIm54TcVvkNZsWHFMmr13aeruEEUvb1H0zKF+9JBpFjA++AfUqRfENV3RU42pTzk
         FVe+Xwkf/Y4mYEE90gkB0yMN2pmzidt/gm/46wbygGEtgckxLTMsRnHtyVO4RgwtDVmR
         gsgoRagm5w4gv05aouHOhNffZnbmaAGValD5cgz3lgSWjPJcAZr8oTXGw30aO1292Fv8
         Nc/Nj4ZVIWduS0lGKgNjTjRnoXdkyaEHaJO6YumACt4bB9tuwcbHP+vMGEh55FQddppr
         b+6k+jGcqmtAsGdiphLrbvy/ZreMBVlzGYJ5FDxjkvHvIxxejRnemDHmXw+0oxV8Yk4o
         MxGQ==
X-Gm-Message-State: APjAAAXs0Otu8ODVedZZb4oWKZq0AR5i1PErPkVptRLnBlrdEOUwbL3Z
        +lY5J+2pfPTVtvqLsNf0jr47C5WZ2UQwv6D1Xlg=
X-Google-Smtp-Source: APXvYqyCDiuMaRUJVGkdNaVLhab3/ROtmMU7HZ08ptYBHKPp450N+OQ9LKM1H5Oheuz1tEFA6tt6N/m8VlETffmMZD4=
X-Received: by 2002:a81:49c3:: with SMTP id w186mr53593821ywa.31.1564069430642;
 Thu, 25 Jul 2019 08:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190724195719.218307-1-salyzyn@android.com> <20190724195719.218307-4-salyzyn@android.com>
 <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com> <af254162-10bf-1fc5-2286-8d002a287400@android.com>
In-Reply-To: <af254162-10bf-1fc5-2286-8d002a287400@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Jul 2019 18:43:39 +0300
Message-ID: <CAOQ4uxi5S9HTx+wR1U_8vQ-6nyCozykWBZbZwiHhnXBGhXRz8Q@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] overlayfs: add __get xattr method
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 6:03 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 7/24/19 10:48 PM, Amir Goldstein wrote:
> > On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >> Because of the overlayfs getxattr recursion, the incoming inode fails
> >> to update the selinux sid resulting in avc denials being reported
> >> against a target context of u:object_r:unlabeled:s0.
> > This description is too brief for me to understand the root problem.
> > What's wring with the overlayfs getxattr recursion w.r.t the selinux
> > security model?
>
> __vfs_getxattr (the way the security layer acquires the target sid
> without recursing back to security to check the access permissions)
> calls get xattr method, which in overlayfs calls vfs_getxattr on the
> lower layer (which then recurses back to security to check permissions)
> and reports back -EACCES if there was a denial (which is OK) and _no_
> sid copied to caller's inode security data, bubbles back to the security
> layer caller, which reports an invalid avc: message for
> u:object_r:unlabeled:s0 (the uninitialized sid instead of the sid for
> the lower filesystem target). The blocked access is 100% valid, it is
> supposed to be blocked. This does however result in a cosmetic issue
> that makes it impossible to use audit2allow to construct a rule that
> would be usable to fix the access problem.
>

Ahhh you are talking about getting the security.selinux.* xattrs?
I was under the impression (Vivek please correct me if I wrong)
that overlayfs objects cannot have individual security labels and
the only way to label overlayfs objects is by mount options on the
entire mount? Or is this just for lower layer objects?

Anyway, the API I would go for is adding a @flags argument to
get() which can take XATTR_NOSECURITY akin to
FMODE_NONOTIFY, GFP_NOFS, meant to avoid recursions.

Thanks,
Amir.
