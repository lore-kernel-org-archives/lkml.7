Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4266C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C4120857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfCTTrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:47:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:47:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so4111280wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7iWfSPdnTEmHfbdAb3Yr5gnBANIxlsdWT6+dj8lxYk=;
        b=Kq09CDJ/x8t7y/WBc17yuM4dDRgXC5GISkNabab89F5aacHZU8hGtUYeAV+vdo2axD
         /DqLp240fUJ4Rj+IdmSgJQSyka/lAvsyuhpvvge6R/jWZ4/Ki5/w0R5P5LcRppXcpdHy
         XKQLqBJ8SpbGq1zmroOJs4eP21V1TX+zsO2ndTU9Cgh53x49aWoOQc/MiDg/e7BWsoyl
         qt6/0POZzlZRN4pi4vDNAfAlwcJZP27vmkNnegbtYHhN8jOoNIYJ8uxY90a4IfAdf66P
         49b4E/KExYLW9+GqbJN5fHG5pQuuWEdud9tVs+S2ppe/0fMLbV9e0Oc0mZATEc5c6wxT
         vmOg==
X-Gm-Message-State: APjAAAXmwxfVWNtb7wRv0vdPf4fAewMu3VnjwJpEpJuedwYiZ0NA8Xmb
        HjvGqb7YnRSG+ITPzJMfQZJ6K/VOSUM=
X-Google-Smtp-Source: APXvYqwZnuDp8i67WCP0eszsIlkuVJI+3DcT9JOQT/UIxOU6IduAt4xawNbpzaFBRTKm8nhaLJKBrw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr5368277wrr.275.1553111264254;
        Wed, 20 Mar 2019 12:47:44 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q2sm5597576wrd.46.2019.03.20.12.47.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:47:43 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: refactor recvframe_defrag()
To:     Ivan Safonov <insafonov@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190320143144.17663-1-insafonov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e543f35a-37cb-68a1-3001-245693cd1274@redhat.com>
Date:   Wed, 20 Mar 2019 20:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320143144.17663-1-insafonov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-19 15:31, Ivan Safonov wrote:
> Local variables pfhdr and prframe always have a same value,
> so one of them is unnecessary.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>

Patch look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/staging/rtl8188eu/core/rtw_recv.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> index 90eb1a025051..9075e3a2755a 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> @@ -1325,7 +1325,7 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
>   	struct list_head *plist, *phead;
>   	u8 wlanhdr_offset;
>   	u8	curfragnum;
> -	struct recv_frame *pfhdr, *pnfhdr;
> +	struct recv_frame *pnfhdr;
>   	struct recv_frame *prframe, *pnextrframe;
>   	struct __queue *pfree_recv_queue;
>   
> @@ -1334,11 +1334,10 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
>   
>   	phead = get_list_head(defrag_q);
>   	plist = phead->next;
> -	pfhdr = list_entry(plist, struct recv_frame, list);
> -	prframe = pfhdr;
> +	prframe = list_entry(plist, struct recv_frame, list);
>   	list_del_init(&prframe->list);
>   
> -	if (curfragnum != pfhdr->attrib.frag_num) {
> +	if (curfragnum != prframe->attrib.frag_num) {
>   		/* the first fragment number must be 0 */
>   		/* free the whole queue */
>   		rtw_free_recvframe(prframe, pfree_recv_queue);
> @@ -1377,15 +1376,15 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
>   		skb_pull(pnextrframe->pkt, wlanhdr_offset);
>   
>   		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
> -		skb_trim(prframe->pkt, prframe->pkt->len - pfhdr->attrib.icv_len);
> +		skb_trim(prframe->pkt, prframe->pkt->len - prframe->attrib.icv_len);
>   
>   		/* memcpy */
> -		memcpy(skb_tail_pointer(pfhdr->pkt), pnfhdr->pkt->data,
> +		memcpy(skb_tail_pointer(prframe->pkt), pnfhdr->pkt->data,
>   		       pnfhdr->pkt->len);
>   
>   		skb_put(prframe->pkt, pnfhdr->pkt->len);
>   
> -		pfhdr->attrib.icv_len = pnfhdr->attrib.icv_len;
> +		prframe->attrib.icv_len = pnfhdr->attrib.icv_len;
>   		plist = plist->next;
>   	}
>   
> 
