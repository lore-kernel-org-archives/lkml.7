Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46195C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C94420650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+wdYOXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393318AbfIFNfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:35:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45269 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391482AbfIFNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:35:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so5998635lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xs44Y9C5kY9tV3QgTmhRhvweKEdDbOReR13zxyIFFm4=;
        b=P+wdYOXpehdroAADXmlcuh1eKFwYQnN9366FZu4R1fvFkm0lVI+c7zFRMrez/myy5J
         pK+j9uFHU1sR2CyMU8GF6RDjY6C5oRSviR+jOYAkCVKEwx3oBEoAiBW/nuJJnz4QhL9U
         jMaHsJfoXNhassZc0ZQ3K/s4tt4XTdh1E3/oNqSxEUJAa50xZDVRscWWRdkaryc2FdvH
         9nJEZ0TSssBVBeIwazelGPD3TXqdYEFK7pzqeOXqWYx0pDIKalCZr9tlGEbw1q0WpqeT
         YOjoXWtjJ6vELErSJukfsrO5hMk/TH1mq/2XNc1bNVOvbLXJUOIAQ78A23RPEMDppzTS
         CiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xs44Y9C5kY9tV3QgTmhRhvweKEdDbOReR13zxyIFFm4=;
        b=GFCwu/sWKpfrE8rpqO2T62b24AIG4vC/x5Hqr/rLC4Zth/UXDBQhecnOJAPTFxZPVI
         040scZ7vsbH1DgslQnQGJ+eZlGXTszPiWVZoziY5PTvT8jr9wIGjMh2tuMHPcGLS/8iA
         AS0sgkhrWigJ+8a9YB66M0TVFTnd+iazVln5piaDjxtb0W3t0jKWStx+ERP6HYxbeOT0
         zydF0CRCZPQUPD5W5NMNHYd+HEn+6F36Ft/NTlChQb1lvWXTGeRj9vixBaCeqTZ+3g+f
         ld7IoIpEgBWln/39zlgFy/GvEhN7DYKb0944zn/mabcys17uzbkyD92oIlzxNQYO5fQw
         ANcQ==
X-Gm-Message-State: APjAAAUOP6TCvdhXZdEB2CNI7ZL1xwDbZ8S3xMOtKTGxjYtRg2H90147
        /x7uyetRzLPkrM0UU8i1ByqPDKlsQc6LVoVTQXA=
X-Google-Smtp-Source: APXvYqzxJ7WXxHJ/RpsvAOAd7PcptKpBh+T3mH0KMZgK4eRb/w+5tXb58u023SExLR7cXWypmkkwfEQ8EMhzxlF2a9o=
X-Received: by 2002:a2e:83d6:: with SMTP id s22mr5760872ljh.104.1567776947696;
 Fri, 06 Sep 2019 06:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6zYkFk55gzmfwMFzpWiOp0xP3DXdmWyO2Ce8+mqYW12SNw@mail.gmail.com> <61bd1ea6-10b7-a1ee-fd79-327abf09fd73@oracle.com>
In-Reply-To: <61bd1ea6-10b7-a1ee-fd79-327abf09fd73@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 6 Sep 2019 19:05:36 +0530
Message-ID: <CAFqt6zZeenG495uAL09zXxTW+OeUrRzY+8eWd8CSzsu=xOZ2_A@mail.gmail.com>
Subject: Re: [PATCH v2] swiotlb-xen: Convert to use macro
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     konrad.wilk@oracle.com, Juergen Gross <jgross@suse.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:02 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 9/6/19 8:27 AM, Souptick Joarder wrote:
> > On Mon, Sep 2, 2019 at 2:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> Rather than using static int max_dma_bits, this
> >> can be coverted to use as macro.
> >>
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> Reviewed-by: Juergen Gross <jgross@suse.com>
> > If it is still not late, can we get this patch in queue for 5.4 ?
>
>
> Yes, I will queue it later today.

Thanks Boris.
