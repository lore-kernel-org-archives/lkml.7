Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5499C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7543F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP1dp69v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfDVO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:58:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:58:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so1356469pgv.11;
        Mon, 22 Apr 2019 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gm5SMZUgMkTV9ecwfINW1s9a9w+WILV3SsQGv+JtbrU=;
        b=nP1dp69vd94fGg/oHXGbYhip2Q07o8sq+68IoyMu/0yx+N60Rn95pLyGhbZ+PCOSg5
         uc2chYJQiHVEG4JFR8sn8q+x0A5PInQLxze1QM8Sw09PThjwJH1u+jCRNTuwdfTZ6dPU
         JwqVlEaZOB4VXbMuzhOTJhrIV3b/ExeWRM1ZqoSwtwMwqIde2UlDNxa2M9BtMaS4Pfjb
         43x6hTBiVZhOfqyt3wjY/lG1caBwyGWTL2YhjfvSjrzpzyeJJHVbI5wiRJjS8UrSqG15
         jJ5w/sJxqeZyb7aLgw8yJRwWBTwTvyNrAtejDKgEC/sLP5SMViHF/iJf/pu10gN+n4Xl
         kCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gm5SMZUgMkTV9ecwfINW1s9a9w+WILV3SsQGv+JtbrU=;
        b=PQdeKlQFbNrQBXKfH/PQJTQdRQa5t+TRr4h5v3eaMfyRqbn7qs4MlecZeMABHN8iPj
         P4uIUnOpg8hB3UjybMBDGZ4S8Cscrl2lkrgUhb1+ySTWrA0DqI+k5zPfXp7JW78m+qkD
         qU1EGm/cqBbh9rZWFd3TSjXT1LzbdO3GfDd6rf5hqAQ7W1vpOgoJJ1NeHjA51g7pw7UG
         93X1G8aKsOv7XDFAXvnrZd5aoZvYWSbSr/0diTrk7Ym6EpkohOQsLQYeTAdux34McFI9
         tekjr/JJiwy7PLYzjJ3BrcVQ+qkg5PSSTq+AulmIR9RgMb70KfIfd9hYvahfejPjZEJl
         59ZA==
X-Gm-Message-State: APjAAAWmsrbHmdRZ/W5gsKoNUc6mK9GI74TdrzQc5TyNK8siPme5fZ1P
        r33jOTDG/5QJUFIfoUiaqBqAuN63
X-Google-Smtp-Source: APXvYqzJEkSIE0HeS649WUFyH1dJHgl7Kh7atrVk1xp9qleDVyDsxd7Y9v+0dgaBCr9RPqs10VoO6A==
X-Received: by 2002:a62:1815:: with SMTP id 21mr20989815pfy.107.1555945114253;
        Mon, 22 Apr 2019 07:58:34 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:80e:6623:574:bedf? ([2601:282:800:fd80:80e:6623:574:bedf])
        by smtp.googlemail.com with ESMTPSA id q77sm31283833pfi.45.2019.04.22.07.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:58:33 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     Stephen Suryaputra <ssuryaextr@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Julian Anastasov <ja@ssi.bg>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <dc7c06ae-204d-c287-04a4-d48875476d09@gmail.com>
 <20190421204126.GA19213@ubuntu>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <458669e6-3d94-1daf-f80b-3c8d740790fa@gmail.com>
Date:   Mon, 22 Apr 2019 08:58:31 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190421204126.GA19213@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/19 2:41 PM, Stephen Suryaputra wrote:
> Hi David,
> 
> I looked at patchwork. This patch hasn't been accepted. Is there a plan
> to resubmit? It is very useful. I had to debug refcnt issues multiple
> times for my employer.

I think the inlined versions of dev_put and dev_hold are better for
performance.

I could submit it with a DEBUG config to enable. It has been invaluable
to me over the past 3+ years debugging refcount problems.
