Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30AAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997E3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Fpfim0KL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfIDHyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:54:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33766 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfIDHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:54:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so19703391oto.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nsL2dG0Jkv/yBtdq643XdQgXacAtlmVt/WZU7C9r86Q=;
        b=Fpfim0KLgJ+FNUELGd/cGbfkJVwz26hJlETB2SD4TW1Yi+H4dORrDsb+7WOsgUCfCa
         wvIESBCC6aMyklaV4lbBJAoUZOpTVEfCpEgrnDEPYSaTF5HzRKGBzIWCpRMC+wTI2Kse
         X2iSsZIejDC/X+uhwFkMzF8Ia0FiRe8aLWGxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nsL2dG0Jkv/yBtdq643XdQgXacAtlmVt/WZU7C9r86Q=;
        b=jjsMjU0cyxJ9iSAigU93A9Nm7M4SGgqKwbUOWY+Fk9Bsl5sa0zcpgKvKMTOOmhpi1X
         PT4TNId/QGoFYq6C2XExF2wg8+63g37kIqMTF4jO4cghJ/NpGg6QThQW2nx2+zhDiHrw
         nCgIwGd9gKezJqFZlj//NLkQQ4rIDqertLdlR239AbLM/4TfOTT8kXUSiN1Wjqkz1nTF
         nkqLZFKtEBYlXOkItiNTgDw83d61uZBeFeNGfZGgJnbfEsjOWQGqrbe0UzAjBG5g/BGg
         IWT39nt+bSdhuI7L9tYsTrEnVhkl12TjbdvWUBo4I+zD6gIe8lAw/fLCpiSorAEl0Fzz
         FzNw==
X-Gm-Message-State: APjAAAWHPocRC91s8Zf5Os7a5FHCaqRIVew1dI/SDegKrSabqhqJJE5d
        mcrO53mtYP4HhMrRgM4TFJ2pHs4yLd3c8dEYAqzodg==
X-Google-Smtp-Source: APXvYqxIAUAvfPNM73tpeSvNr//yloLprQQu73fJhL+XKHcnaBcmH7124BD4NPk5vIXaT6rUNf8CFt+b+b0Z/W6osOs=
X-Received: by 2002:a05:6830:10d8:: with SMTP id z24mr11461873oto.281.1567583645124;
 Wed, 04 Sep 2019 00:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org> <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com> <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com> <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
 <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org> <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
 <B3C5DD1B-A33C-417F-BDDC-73120A035EA5@amacapital.net> <3393108b-c7e3-c9be-b65b-5860c15ca228@shipmail.org>
In-Reply-To: <3393108b-c7e3-c9be-b65b-5860c15ca228@shipmail.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 4 Sep 2019 09:53:53 +0200
Message-ID: <CAKMK7uH0jxaWJLxfXfGLyN-Rb=0ZKUFTkrEPdFCuGCh4ORCv9w@mail.gmail.com>
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

On Wed, Sep 4, 2019 at 8:49 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
> On 9/4/19 1:15 AM, Andy Lutomirski wrote:
> > But, reading this, I have more questions:
> >
> > Can=E2=80=99t you get rid of cvma by using vmf_insert_pfn_prot()?
>
> It looks like that, although there are comments in the code about
> serious performance problems using VM_PFNMAP / vmf_insert_pfn() with
> write-combining and PAT, so that would require some serious testing with
> hardware I don't have. But I guess there is definitely room for
> improvement here. Ideally we'd like to be able to change the
> vma->vm_page_prot within fault(). But we can

Just a quick comment on this: It's the repeated (per-pfn/pte) lookup
of the PAT tables, which are dead slow. If you have a struct
io_mapping then that can be done once, and then just blindly inserted.
See remap_io_mapping in i915.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
