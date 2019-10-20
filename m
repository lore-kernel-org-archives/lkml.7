Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B56CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F2D21929
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571598586;
	bh=q+SNoyLgu/l1SWVD0v1n4bg2iKbjViIVFGsPMw+F+Sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ekyqfiWIvtrEzdWu2iVYEBTABjTBCJ/oB4ziUD/hAAurC1i0Sq/FsT/p0IfgfVm7f
	 zgks5iT0iAXTSQY5yh9ecQj5YWNaHhqVYCvnZqNibYF68xtJnTmi+ofSY/+NviojSj
	 0gfZeh81fs0nPgkSOVUxMt3IAoYMVnUmFmRLiXwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfJTTJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfJTTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:09:43 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E58222BD;
        Sun, 20 Oct 2019 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571598582;
        bh=q+SNoyLgu/l1SWVD0v1n4bg2iKbjViIVFGsPMw+F+Sg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QyJ0u1gsmZ/V7MnfqumkZzYuh3gOFfX0eFw6KmAymq1IxqoEZyac6XlVLqS6Yy8Np
         R+qOurhoRpM/AO2NMSDBtJ/StVnhcu2Gc6JMe4A1lir+Yqr6kyQObqkN8nOoeMvFO6
         FlPbW1TkQ6fo/05GZ4EPCfyKgN2oymnPGtilANoM=
Received: by mail-qk1-f175.google.com with SMTP id 71so6433806qkl.0;
        Sun, 20 Oct 2019 12:09:42 -0700 (PDT)
X-Gm-Message-State: APjAAAWId48mqMupjnQtPVK/ptvmX2z+J0CpnT1mWuSHsDRWzY/kBhZO
        NxZFIDPndoudp7M4c+V/S+DXmiQed6iFfvnOPw==
X-Google-Smtp-Source: APXvYqxCZdoSJOPws5ld0rBfQmiAIurX/KPccb8UPTZj2Xd7JXOnejqxFnBHAVEABVkT9T6d/ENfL9Tq+XQMwqbKO64=
X-Received: by 2002:a37:9847:: with SMTP id a68mr10386178qke.223.1571598581555;
 Sun, 20 Oct 2019 12:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
 <20191017191152.GA11222@bogus> <20191019150652.h6bkfz2w2ohemvwy@smtp.gmail.com>
In-Reply-To: <20191019150652.h6bkfz2w2ohemvwy@smtp.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 20 Oct 2019 14:09:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqgko02KstmytNNUUF0-QR7rpMF4dV=X55N=TnDahd+Q@mail.gmail.com>
Message-ID: <CAL_JsqKqgko02KstmytNNUUF0-QR7rpMF4dV=X55N=TnDahd+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 10:07 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi Rob
>
> Thanks for the review.
>
> I'm having some trouble with the DTC.
> I installed the DT tool from https://github.com/robherring/dt-schema.
> Running make -k dt_binding_check goes through all the checks (CHKDT), producing
> the .example.dts files but then gives errors like:
>
>   DTC     Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml
> FATAL ERROR: Unknown output format "yaml"
> make[1]: *** [scripts/Makefile.lib:314: Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml] Error 1
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml'
>
> My pip3 installation has:
> jsonschema jsonschema-3.1.2.dev6+g0d827f3
> rfc3987 1.3.8
>
> $HOME/.local/bin is listed in my shell's PATH variable.
>
> I was trying to follow the documentation at:
> Documentation/devicetree/writing-schema.rst
>
> Are there any other DTC dependencies that I am missing?

Yes, libyaml. See Documentation/devicetree/writing-schema.rst.

Rob
