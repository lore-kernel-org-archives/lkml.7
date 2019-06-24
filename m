Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF70C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9420665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1JNiS8o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfFXWqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:46:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37740 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfFXWqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:46:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so11083748qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=l+t11w+lYzgMdf9afpAfNi/wBZxJpJdB0Y+rhM6lHks=;
        b=1JNiS8o8LLcLGJ7yDeuoGqe7R53WxwUnBJ473OA/Sj94hjFkUtbMZgxLmpjtFcBKa6
         N8tfCq4i4n89X7x24u4RaZsPtxHqdSZxpQvXnuae5hnCD5wud1xsEgxlwfhTEoVI9cPt
         g3jQIXuW7CiLlgUVdgWO8zSkn1nQjlMb25O4W634mUf1mJezM/d1gtgwSbKc319j57bs
         dLGovYfEKNj36SFTmOEAS+n8b5B1My2OgGKfdHQcGOBv6EgC/AuW1Oqplc0bR0zzeUgo
         jYXXxiIhD1iH9bA0rFt9Qmmx+ThDGH8ng7MqzQSE2+OlYR7eeju/cBxmDLZn9ZaILbBX
         PPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=l+t11w+lYzgMdf9afpAfNi/wBZxJpJdB0Y+rhM6lHks=;
        b=NjZo/l6wYrqynOYKMdTj30aJLOyJr09+HwvpPZ2zV7GI8wG+RjCwlui7qsh0kmje8h
         ckhmbmznHZbWJFCJ048fHmEy9ID2CXaqL+1POLl5UnkkWqOAX1o3M3aOfX3w+Oj67xk1
         oxHYjDU7wzgu5rPWsEHssIzpw97+oO21TQtGGGCmdY21lFgCwzXNvEYW58XCGydNpS33
         NhbenDRnXdUwDMeXfR3MC+gO5Rcx9Wwx+C378gf8vkKuDC9/ZEMm5txDIm2GhXr3ZgIF
         cfr4EFIej/ncCOdQK0UdZ38JbbQZLXEgq4AN9+mdNAETyzgC4XnKnTKWvrNEvWdZ/F6T
         Eq8A==
X-Gm-Message-State: APjAAAXinVkb6oWnfRlLuXXvegQvNSgaeQTfKQO8fGX7POBU0hYHoKhv
        sIAhhdS6xRZbNTqEfFyPYXYDvQ==
X-Google-Smtp-Source: APXvYqx2gLjuzKn7dYRM+5cj5gK6T/0dtP3tloIyQ3TQPgnYyzTA7/groXjMvqklxlRwTCwpzetNWQ==
X-Received: by 2002:ae9:e608:: with SMTP id z8mr114743476qkf.182.1561416362271;
        Mon, 24 Jun 2019 15:46:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k40sm7384209qta.50.2019.06.24.15.46.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 15:46:02 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:45:58 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Brian Vazquez <brianvv@google.com>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] bpf: add BPF_MAP_DUMP command to access more
 than one entry per call
Message-ID: <20190624154558.65c31561@cakuba.netronome.com>
In-Reply-To: <20190621231650.32073-3-brianvv@google.com>
References: <20190621231650.32073-1-brianvv@google.com>
        <20190621231650.32073-3-brianvv@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 16:16:46 -0700, Brian Vazquez wrote:
> @@ -385,6 +386,14 @@ union bpf_attr {
>  		__u64		flags;
>  	};
>  
> +	struct { /* struct used by BPF_MAP_DUMP command */
> +		__u32		map_fd;

There is a hole here, perhaps flags don't have to be 64 bit?

> +		__aligned_u64	prev_key;
> +		__aligned_u64	buf;
> +		__aligned_u64	buf_len; /* input/output: len of buf */
> +		__u64		flags;
> +	} dump;
> +
>  	struct { /* anonymous struct used by BPF_PROG_LOAD command */
>  		__u32		prog_type;	/* one of enum bpf_prog_type */
>  		__u32		insn_cnt;
