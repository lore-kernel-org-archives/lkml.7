Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32099C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0674B2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skSNF0YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGBRMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:12:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40803 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfGBRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:12:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so18735491wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hJpnw7hCIa1iclA3boS73/qi+CJie1UIDbfpV6vNFsI=;
        b=skSNF0YX1iCPVBjl+LYaZx2phGmvhkrMSY9JoCHRdr0UNp74Xjc8mEYXXMo0CUJi4r
         KRk2nRStJw7c1HcktbPctgO6qvI61bNqvE3m8s4CsL6XuqP//mQzCmYGww9ocGk996C+
         7rDYf+05cDE+O1X8y7O37MzUtZ/nrYqbXdu07QrQSuIJrMCqnZO7L7ibcpKG1MNNUiYd
         HxVJTYvLLvU28SDRWL1oBs7BT3oi42UpI4CpNryq/NzhPL0tVEDBbnD7cJm+WupQgWkG
         pGoDmmRsq/TypsdFd+fPXwqaU+AOKAbGRlt3m0wJcMX90OphWsAsoh55cUkPZzCz2GfL
         3yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hJpnw7hCIa1iclA3boS73/qi+CJie1UIDbfpV6vNFsI=;
        b=nrqAgO6OzNHSjsZT3RdxJj3LITZUydtFsMwaKOl/gijHMzXaqUCU8lbghIhEi3IF77
         SsyujGGwZd2EzTf3E4cBw5VWSJL1AjAEBRzKG0YuKsiwhvsHXfCQabHPxu2nEsQ46WAU
         zW5fCbr+JtmXC6iQyHdX5cDVtMNwVhgCXN9swBRo98hdVRzZIJ4HLt19fXA8qi9+DUjY
         9fPbphII1HMRjoO17V3xvjGfhw+20TJd8YhRFdd9OP3ly/SoWQIZttINJi4Oq1r+8qOt
         p8jp7asfIbdxlE8BPmaSKKRdiEp7U8mlgMKF1XlDCAA/sY5gukb+LNEVRI1XbrBjoVva
         pAng==
X-Gm-Message-State: APjAAAVvYSSIiqVh1sP0sBjXI6b1zAG5XFAHbfQ3l8AbTeMhNKNB7hah
        XltXeTglzYY3cvV7lFqLwQ==
X-Google-Smtp-Source: APXvYqyEEu4qtNoxuTGw7rtAzwvW0HbLbm8wc+ZfK9OFaKuhLTUyUiYEziVbqz3mMy4QkygKNdl61Q==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr23772529wrn.244.1562087571285;
        Tue, 02 Jul 2019 10:12:51 -0700 (PDT)
Received: from avx2 ([46.53.251.222])
        by smtp.gmail.com with ESMTPSA id i188sm4041407wma.27.2019.07.02.10.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 10:12:50 -0700 (PDT)
Date:   Tue, 2 Jul 2019 20:12:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mcroce@redhat.com
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        atomlin@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH] proc/sysctl: add shared variables for range check
Message-ID: <20190702170228.GA4404@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static long zero;
>  static long long_max = LONG_MAX;
> 
>  struct ctl_table epoll_table[] = {
> @@ -301,7 +300,7 @@ struct ctl_table epoll_table[] = {
>                 .maxlen         = sizeof(max_user_watches),
>                 .mode           = 0644,
>                 .proc_handler   = proc_doulongvec_minmax,
> -               .extra1         = &zero,
> +               .extra1         = SYSCTL_ZERO,
>                 .extra2         = &long_max,

This looks wrong: proc_doulongvec_minmax() expects "long"s.
The whole patch needs rechecking.

> +/* shared constants to be used in various sysctls */
> +const =======>int<========== sysctl_vals[] = { 0, 1, INT_MAX };
> +EXPORT_SYMBOL(sysctl_vals);
