Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B21C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921D2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbfKEK3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:29:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37601 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbfKEK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:29:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id q130so19461501wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hRJAdazyUkO8QdsK0VqUEQnxhaK9qZNY29WW2qN+f8U=;
        b=T35zIJfgWNQua72noRje8BM+oP944kMJYcUkeAcYKLd4Yc73SuMEaYDSJ2H4bamml+
         No5Y60pdzagSyqmRrmRvKqxn4RgTJi4Hgw7Cp662kMKb4x5ejkB0ymRPG+lNDegmQ3P8
         O1/MNHedQbSqAXV/k7qI+T85bKd2iK/iGGVFG1kuw8oHwBpHe8/yNZDikj7eCJDWxbnB
         CT1JVFVovrQsKfNlIQRYZMsJAJzjke/wRiy0R2Bn7fWXZVIyVO+r0tVrpgoJse9DXB9H
         AEVCbw77cfYEb1ejixiJyq3AlAr1zNefPYDsulTg22blRbYcCefjpa0Iju19jgaBwLCw
         hmgQ==
X-Gm-Message-State: APjAAAWazgC2nLAEXN7Pgz+yHVtK1//FwjENMIUg8k9irJK8Ydu0jMIF
        HXPyew3iPzUwskvmYLY7rkk=
X-Google-Smtp-Source: APXvYqw1uMRjTttRxc88oIOP6BYDmtYz56sByR120GsP72qLfE64s//GGSNnXUJsTFMRjVuQOmcGog==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr3289499wmj.36.1572949746101;
        Tue, 05 Nov 2019 02:29:06 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id w4sm13084540wmi.39.2019.11.05.02.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:29:05 -0800 (PST)
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Or Cohen <orcohen@paloaltonetworks.com>,
        Greg KH <gregkh@linuxfoundation.org>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
 <20191104152428.GA2252441@kroah.com>
 <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
 <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr>
 <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com>
 <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com>
 <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com>
 <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fb1744cd-2680-1459-16de-8d6a4afd666d@suse.com>
Date:   Tue, 5 Nov 2019 11:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 19, 10:33, Nicolas Pitre wrote:
> Subject: [PATCH] vcs: prevent write access to vcsu devices
> 
> Commit d21b0be246bf ("vt: introduce unicode mode for /dev/vcs") guarded
> against using devices containing attributes as this is not yet
> implemented. It however failed to guard against writes to any devices
> as this is also unimplemented.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Cc: <stable@vger.kernel.org> # v4.19+
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index fa07d79027..ef19b95b73 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -456,6 +456,9 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>  	size_t ret;
>  	char *con_buf;
>  
> +	if (use_unicode(inode))
> +		return -EOPNOTSUPP;

Looks good to me. I am also thinking about a ban directly in open:

if (use_unicode(inode) && (filp->f_flags & O_ACCMODE) != O_RDONLY)
  return -EOPNOTSUPP;

Would that break the unicode users?

thanks,
-- 
js
suse labs
