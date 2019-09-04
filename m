Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B634C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376422CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cOrLS8VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfIDLoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:44:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36383 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:44:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so9112475oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+j6qs7WQfu4dAUrdhez3m/4Ue+xLmyXGa3x2aGEysyw=;
        b=cOrLS8VV/hmB7qdaVJRgYtWT5lCOR/hUsT57DW7q6z6LIS5TBoOE4yPL2XvAxV9t7B
         OuVwOo0aQJVX5uzcIMcroh0aWTvvrk02+fOJB8SB75FOYuuXDVdVD9YWjT5yn4CyIQmp
         qBNA9TyjJvMfKwF17RDqtObPuToCbHTcvTFNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+j6qs7WQfu4dAUrdhez3m/4Ue+xLmyXGa3x2aGEysyw=;
        b=J/nmAtClNFSWahZe9eTRhzMYEtVw/aUkVUqiiF/3V9RNQHQPHZzMpdJn8B4UnILC90
         7ubukE9NVCFu7vIXQPPJbn7EkNwdeZLuXYabmdA1K72R2tQDyOekyvCBBq0t73AY11sL
         hdkiL03tkcpEs405PAITK6fZVlNPRa3fah2qOBfV7BmPUbkvQ6PabXqTsw/hCiaNe0Tn
         p2tJt6dDx4yBn80Iu24uC4fnr0aCfoUab8TGD0vyOLsrkMAlm0+qa3rIY5HS1t9Wv1dl
         q0FND4gDp2jv8GCvOhYC+7y53VCy8SR5v1Td3amBoSyCZ50THT6L1AA5rj6LHQfERYOW
         xBFQ==
X-Gm-Message-State: APjAAAUDZXE3mYQibnqHfz2g9ZsHyK4mi2rSj/S37JJL4CSL5ILWcH23
        39NPi3iBzMUiJ+LF4H1ywSZCQDSaUybcda23L7WtVQ==
X-Google-Smtp-Source: APXvYqx2jqlv3dUQJsCCVgaOhAfgDv9rgsHFd3fDcbcS6XpqczhHB6lDb16xvUPJbP1/L4REmqwCaUtBgJqYnidviGY=
X-Received: by 2002:aca:e182:: with SMTP id y124mr2872478oig.132.1567597447659;
 Wed, 04 Sep 2019 04:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org> <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com> <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com> <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
 <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org> <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
 <B3C5DD1B-A33C-417F-BDDC-73120A035EA5@amacapital.net> <3393108b-c7e3-c9be-b65b-5860c15ca228@shipmail.org>
 <CAKMK7uH0jxaWJLxfXfGLyN-Rb=0ZKUFTkrEPdFCuGCh4ORCv9w@mail.gmail.com> <0fd10438-5da4-fb69-f40c-c9b4beea1977@shipmail.org>
In-Reply-To: <0fd10438-5da4-fb69-f40c-c9b4beea1977@shipmail.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 4 Sep 2019 13:43:56 +0200
Message-ID: <CAKMK7uGPWj8pU0FCV_2aR6sDQgw9VAimkG3hnGcQJsxE1-2_kQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        pv-drivers@vmware.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 12:38 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> On 9/4/19 9:53 AM, Daniel Vetter wrote:
> > On Wed, Sep 4, 2019 at 8:49 AM Thomas Hellstr=C3=B6m (VMware)
> > <thomas_os@shipmail.org> wrote:
> >> On 9/4/19 1:15 AM, Andy Lutomirski wrote:
> >>> But, reading this, I have more questions:
> >>>
> >>> Can=E2=80=99t you get rid of cvma by using vmf_insert_pfn_prot()?
> >> It looks like that, although there are comments in the code about
> >> serious performance problems using VM_PFNMAP / vmf_insert_pfn() with
> >> write-combining and PAT, so that would require some serious testing wi=
th
> >> hardware I don't have. But I guess there is definitely room for
> >> improvement here. Ideally we'd like to be able to change the
> >> vma->vm_page_prot within fault(). But we can
> > Just a quick comment on this: It's the repeated (per-pfn/pte) lookup
> > of the PAT tables, which are dead slow. If you have a struct
> > io_mapping then that can be done once, and then just blindly inserted.
> > See remap_io_mapping in i915.
> > -Daniel
>
> Thanks, Daniel.
>
> Indeed looks a lot like remap_pfn_range(), but usable at fault time?

Yeah we call it from our fault handler. It's essentially vm_insert_pfn
except the pat track isn't there, but instead relies on the pat
tracking io_mapping has done already.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
