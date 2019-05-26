Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21DC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703F920815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 15:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfEZPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 11:37:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46023 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfEZPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 11:37:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so2991225pga.12;
        Sun, 26 May 2019 08:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=URGml5/Z89pUst9mDYx5afNNgEbFqd7kb3vtTLohUmw=;
        b=En3WiXfP/CRsoLLfHEjTIRqYAnSZiZbZt2dd7wRCdiXQOUD0gI0JQF5qe/UivFYDBb
         Ds6OfpVH6kNISutLf5pnT2YqtJHVxK0YMIX6coCwI+NV41gvzgj7a2qUTPHsG/EDc3D3
         TpeKsaDIiY3nhyfbZfumtz56NOh0ditZLsAn/nKEEhsdGZ/dklNmLzPIrIiUISeH5XdX
         JKDmWsQLIxtmo0BhivCdz1lYyzzxTrByYPcS81fevj+PQJ6CB2BBEqJth6vWFGJjc/Ep
         oKEHJhoMaQfqko5JTj0zxJEIAUdNCux2hhiEcwbXQQ/2ajaBIbAoAZLkwiYav1Tq8BdK
         LhWw==
X-Gm-Message-State: APjAAAUvvcnkQqVqhL76xy3Kjikq/gfbzMHOcffgF1BpV0KD+OIj2Zgq
        OezbZtKxC1C6W/5iucSwWfW9LfCB
X-Google-Smtp-Source: APXvYqy9T603n8qQzto83AO2/b0/mhODJYy/zzI98wbVtqIz/FuiU3uXlkpieijJaSOxwvKB1QugvQ==
X-Received: by 2002:a05:6a00:cc:: with SMTP id e12mr16068634pfj.207.1558885039820;
        Sun, 26 May 2019 08:37:19 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id t2sm8513249pfh.166.2019.05.26.08.37.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:37:18 -0700 (PDT)
Subject: Re: [PATCH] drivers/scsi: fix warning PTR_ERR_OR_ZERO can be used
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Wei Li <liwei213@huawei.com>,
        Geng Jianfeng <gengjianfeng@hisilicon.com>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kangjie Lu <kjlu@umn.edu>, Arnd Bergmann <arnd@arndb.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190525094205.GA21778@hari-Inspiron-1545>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <2f7f51f7-e2a1-6667-3fed-642157437ea2@acm.org>
Date:   Sun, 26 May 2019 08:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525094205.GA21778@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/19 2:42 AM, Hariprasad Kelam wrote:
> fix below warnig reported by coccicheck
> 
> /drivers/scsi/ufs/ufs-hisi.c:459:1-3: WARNING: PTR_ERR_OR_ZERO can be
> used
> ./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1477:1-3: WARNING: PTR_ERR_OR_ZERO
> can be used
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/scsi/qla2xxx/tcm_qla2xxx.c | 4 +---
>  drivers/scsi/ufs/ufs-hisi.c        | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
> index ec9f199..4357b34 100644
> --- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
> +++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
> @@ -1474,10 +1474,8 @@ static int tcm_qla2xxx_check_initiator_node_acl(
>  				       sizeof(struct qla_tgt_cmd),
>  				       TARGET_PROT_ALL, port_name,
>  				       qlat_sess, tcm_qla2xxx_session_cb);
> -	if (IS_ERR(se_sess))
> -		return PTR_ERR(se_sess);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(se_sess);
>  }
>  
>  static void tcm_qla2xxx_update_sess(struct fc_port *sess, port_id_t s_id,
> diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
> index 7aed0a1..f506044 100644
> --- a/drivers/scsi/ufs/ufs-hisi.c
> +++ b/drivers/scsi/ufs/ufs-hisi.c
> @@ -456,10 +456,8 @@ static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
>  	/* get resource of ufs sys ctrl */
>  	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
> -	if (IS_ERR(host->ufs_sys_ctrl))
> -		return PTR_ERR(host->ufs_sys_ctrl);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(host->ufs_sys_ctrl);
>  }

Although I'm not sure this patch improves readability of the source code:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

