Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5DDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A719321850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKSNuYim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfGXOnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:43:20 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33373 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfGXOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:43:20 -0400
Received: by mail-qt1-f172.google.com with SMTP id r6so41501045qtt.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hhwWMTyEvMH3Y8XcTDW/iVp/DTf0XVaB1tiSVtDZri8=;
        b=iKSNuYim7mWdkT53o25ofN5wgS6aXiS6LNRhncAP4giCAwrEXPXh5utjUFMBM27RJP
         9c6UJaRTQC+AmBmzYHXOs3lgRPprl8ihDXDsvSl8ntkB7m0Y21Is6HeUtsEbrdSTUuqE
         8a3Pe84Gq6Z51VAQgOPNyO6zrsa/JhWhrKHFq6dJlxjSAQGOwK0ZxYQCkBLmzKdIAKnQ
         /z6YuxTQO/oNYv+hgq20WQwCaR+aXDD7f/KNmTDsosYLvRN8PvslfZ3bs9e6U/DpBUX4
         zTF1Jy1xsw/Neq3QPQO8iYbrFlS8WHInuB+/47R+jtYEAXqKoX0LaUnOkGl1VrSsF6Qg
         qJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hhwWMTyEvMH3Y8XcTDW/iVp/DTf0XVaB1tiSVtDZri8=;
        b=hbGWc5eYIEWRaAVySGABlwIuebCOLnrvUxEYP87Q00qgpuk4bu8/2S59vz22j6j0OB
         pff53YjBfpSIhVB9Fr7o5j5zpmLcEBuk1knryPFx/8mX3JEBJsXXUexi8WcFeAWtdGYQ
         QhwV7GHv3DQGA0iQG9sygQjuv5ksqjUPFsAiB5Dxw6brejHDTjyVPownaAAUxp0ne6gJ
         82SKa3cz83XcmixSbBxMUp3tjDGRQAIJ6ysVfkIVf97KygJNCn4YS2LvI5kH1+6BZVnW
         F4t7aRseXZreRorxfcr/QEaxMckssCCxLdXXaOUasI2vXW72IKBXpazZDSoD1LO85+s4
         NmRQ==
X-Gm-Message-State: APjAAAUocy7XOKZ/ZG1JGfjbUbwIjawttGTVdCGOeZg7o2UMrxDthjlq
        CSv2/kIEBy0GpyThvwpPOOCptLkdRn+z63qaueyyEEbp
X-Google-Smtp-Source: APXvYqy60lFAXsMJILlxHftSozBiF6+CPYctJIFODYfoi0TMCA88IlYB7fdKx4svIuZlStxD9s3YoJIFCviRt4zCbmc=
X-Received: by 2002:ac8:540e:: with SMTP id b14mr52946592qtq.134.1563979399042;
 Wed, 24 Jul 2019 07:43:19 -0700 (PDT)
MIME-Version: 1.0
From:   Gilberto Nunes <gilberto.nunes32@gmail.com>
Date:   Wed, 24 Jul 2019 11:42:42 -0300
Message-ID: <CAOKSTBv5-1aNwOrhXp0GtK4ROx_NQ6fhCbrnj7PsNPp+NPAhMg@mail.gmail.com>
Subject: How to disable amdgpu powerplay?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I have a laptop AMD A12 with amdgpu.
When I use kernel 5.X I have trouble with powerplay!

https://paste.ubuntu.com/p/YhbjnzYYYh/

Is there same kernel boot parameters to use in order to disable powerplay??

Thanks
