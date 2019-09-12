Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EACC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C539620CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MnrpSr8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfILWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:19:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32806 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfILWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id o9so25382975edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dK4o6dl/7k0HCpJemfy1AOx7XfulKp/y7Y2l+778zo=;
        b=MnrpSr8OFbUR73YPCiFSENtn5ZudvxI7OwGw6GNjvgUjjybkbx432HAL63fXMhJuZM
         ngpRNJkTiJVcXgesn0lmuAjELqbvk4g190sfqoXSjzv1tcfGy3H67U8RfjNULeQc1lMQ
         0/y6ns3V0zJuVPUbb4ESVWmFY+VfC8jfSQbz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dK4o6dl/7k0HCpJemfy1AOx7XfulKp/y7Y2l+778zo=;
        b=DunufxN/s+3qHQmJ1BYIXYc6l9PvnZ134zwmy/w2HiSOGVal5hMsLgwkktbf6UopXu
         M4H3xTpH5XtILmCZL045ErGsvFoStO7Sj26iVbQr01Y780GjxOq0hkNcSyHAK85So6R/
         1iRQ2NWjYWg5W8SUz6hdBs+pdmIvyvWHDSdrn+uRVxbv5Kvt880lsWnsOdZPMggCOeb2
         a3xO5+xPRk/Gqdd744Itweajn8B29GTifs492pnXgffP/WrojJwlt4SyRmCaVAvr5z10
         X4Eb1KqGS2RH3BsEGWiamTOCoWJQD1rUctrC+VC+v98De19Q3aCchqQXXQroUFZmR8ff
         3p/g==
X-Gm-Message-State: APjAAAWZxKe6l9VDld8Fc5eDoWeHowXz7Ti/LxfRYPOF9l9ZUQtKFEqG
        e3WNdZinkodNgpSDMufkVcvI5g==
X-Google-Smtp-Source: APXvYqwhmp7m9l0ZozQsFj7o/TX+MBXcwX85gJEqruFgFrxoSCT1Fows0L+pH5PcyJeX3ioivkCTPw==
X-Received: by 2002:a50:ee92:: with SMTP id f18mr22895665edr.253.1568326783719;
        Thu, 12 Sep 2019 15:19:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 1/6] staging: rtl8723bs: replace __inline by inline
Date:   Fri, 13 Sep 2019 00:19:22 +0200
Message-Id: <20190912221927.18641-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __inline is #defined as inline in compiler_types.h, so this
should not change functionality. It is preparation for removing said
#define.

While at it, change some "inline static" to the customary "static
inline" order.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c     |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h    |  6 +++---
 .../staging/rtl8723bs/include/osdep_service.h    | 10 +++++-----
 .../rtl8723bs/include/osdep_service_linux.h      | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_mlme.h     | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_recv.h     | 16 ++++++++--------
 drivers/staging/rtl8723bs/include/sta_info.h     |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h         | 14 +++++++-------
 drivers/staging/rtl8723bs/include/wlan_bssdef.h  |  2 +-
 10 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index ae7fb7046c93..3750fbaeec4f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -830,12 +830,12 @@ static void pwr_rpwm_timeout_handler(struct timer_list *t)
 	_set_workitem(&pwrpriv->rpwmtimeoutwi);
 }
 
-static __inline void register_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
+static inline void register_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
 {
 	pwrctrl->alives |= tag;
 }
 
-static __inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
+static inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
 {
 	pwrctrl->alives &= ~tag;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 76c50377f0fe..34e1ce1b0689 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -451,7 +451,7 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	mutex_unlock(&(adapter_to_dvobj(padapter)->setch_mutex));
 }
 
-__inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
+inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
 {
 	return pnetwork->MacAddress;
 }
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 96346ce064aa..d3648f3b1de2 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -478,7 +478,7 @@ struct sdio_data intf_data;
 #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
 #define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
 
-__inline static struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
+static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 {
 	/* todo: get interface type from dvobj and the return the dev accordingly */
 #ifdef RTW_DVOBJ_CHIP_HW_TYPE
@@ -636,14 +636,14 @@ struct adapter {
 
 /* define RTW_DISABLE_FUNC(padapter, func) (atomic_add(&adapter_to_dvobj(padapter)->disable_func, (func))) */
 /* define RTW_ENABLE_FUNC(padapter, func) (atomic_sub(&adapter_to_dvobj(padapter)->disable_func, (func))) */
-__inline static void RTW_DISABLE_FUNC(struct adapter *padapter, int func_bit)
+static inline void RTW_DISABLE_FUNC(struct adapter *padapter, int func_bit)
 {
 	int	df = atomic_read(&adapter_to_dvobj(padapter)->disable_func);
 	df |= func_bit;
 	atomic_set(&adapter_to_dvobj(padapter)->disable_func, df);
 }
 
-__inline static void RTW_ENABLE_FUNC(struct adapter *padapter, int func_bit)
+static inline void RTW_ENABLE_FUNC(struct adapter *padapter, int func_bit)
 {
 	int	df = atomic_read(&adapter_to_dvobj(padapter)->disable_func);
 	df &= ~(func_bit);
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index d2616af95ffa..81a9c19ecc6a 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -110,12 +110,12 @@ int _rtw_netif_rx(_nic_hdl ndev, struct sk_buff *skb);
 
 extern void _rtw_init_queue(struct __queue	*pqueue);
 
-static __inline void thread_enter(char *name)
+static inline void thread_enter(char *name)
 {
 	allow_signal(SIGTERM);
 }
 
-__inline static void flush_signals_thread(void)
+static inline void flush_signals_thread(void)
 {
 	if (signal_pending (current))
 	{
@@ -125,7 +125,7 @@ __inline static void flush_signals_thread(void)
 
 #define rtw_warn_on(condition) WARN_ON(condition)
 
-__inline static int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *parg4)
+static inline int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *parg4)
 {
 	int ret = true;
 
@@ -136,7 +136,7 @@ __inline static int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *p
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 #define RND4(x)	(((x >> 2) + (((x & 3) == 0) ?  0: 1)) << 2)
 
-__inline static u32 _RND4(u32 sz)
+static inline u32 _RND4(u32 sz)
 {
 
 	u32 val;
@@ -147,7 +147,7 @@ __inline static u32 _RND4(u32 sz)
 
 }
 
-__inline static u32 _RND8(u32 sz)
+static inline u32 _RND8(u32 sz)
 {
 
 	u32 val;
diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 2f1b51e614fb..c582ede1ac12 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -64,12 +64,12 @@
 
 	typedef struct work_struct _workitem;
 
-__inline static struct list_head *get_next(struct list_head	*list)
+static inline struct list_head *get_next(struct list_head	*list)
 {
 	return list->next;
 }
 
-__inline static struct list_head	*get_list_head(struct __queue	*queue)
+static inline struct list_head	*get_list_head(struct __queue	*queue)
 {
 	return (&(queue->queue));
 }
@@ -78,28 +78,28 @@ __inline static struct list_head	*get_list_head(struct __queue	*queue)
 #define LIST_CONTAINOR(ptr, type, member) \
 	container_of(ptr, type, member)
 
-__inline static void _set_timer(_timer *ptimer, u32 delay_time)
+static inline void _set_timer(_timer *ptimer, u32 delay_time)
 {
 	mod_timer(ptimer , (jiffies+(delay_time*HZ/1000)));
 }
 
-__inline static void _cancel_timer(_timer *ptimer, u8 *bcancelled)
+static inline void _cancel_timer(_timer *ptimer, u8 *bcancelled)
 {
 	del_timer_sync(ptimer);
 	*bcancelled =  true;/* true == 1; false == 0 */
 }
 
-__inline static void _init_workitem(_workitem *pwork, void *pfunc, void *cntx)
+static inline void _init_workitem(_workitem *pwork, void *pfunc, void *cntx)
 {
 	INIT_WORK(pwork, pfunc);
 }
 
-__inline static void _set_workitem(_workitem *pwork)
+static inline void _set_workitem(_workitem *pwork)
 {
 	schedule_work(pwork);
 }
 
-__inline static void _cancel_workitem_sync(_workitem *pwork)
+static inline void _cancel_workitem_sync(_workitem *pwork)
 {
 	cancel_work_sync(pwork);
 }
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index d3c07d1c36e9..4282dfa70b79 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -498,13 +498,13 @@ extern sint rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv);
 extern sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, sint keyid, u8 set_tx, bool enqueue);
 extern sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv);
 
-__inline static u8 *get_bssid(struct mlme_priv *pmlmepriv)
+static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
 {	/* if sta_mode:pmlmepriv->cur_network.network.MacAddress => bssid */
 	/*  if adhoc_mode:pmlmepriv->cur_network.network.MacAddress => ibss mac address */
 	return pmlmepriv->cur_network.network.MacAddress;
 }
 
-__inline static sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
+static inline sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	if (pmlmepriv->fw_state & state)
 		return true;
@@ -512,7 +512,7 @@ __inline static sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
 	return false;
 }
 
-__inline static sint get_fwstate(struct mlme_priv *pmlmepriv)
+static inline sint get_fwstate(struct mlme_priv *pmlmepriv)
 {
 	return pmlmepriv->fw_state;
 }
@@ -524,7 +524,7 @@ __inline static sint get_fwstate(struct mlme_priv *pmlmepriv)
  * ### NOTE:#### (!!!!)
  * MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
  */
-__inline static void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
+static inline void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	pmlmepriv->fw_state |= state;
 	/* FOR HW integration */
@@ -533,7 +533,7 @@ __inline static void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
 	}
 }
 
-__inline static void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
+static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
 {
 	pmlmepriv->fw_state &= ~state;
 	/* FOR HW integration */
@@ -546,7 +546,7 @@ __inline static void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
  * No Limit on the calling context,
  * therefore set it to be the critical section...
  */
-__inline static void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
+static inline void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	spin_lock_bh(&pmlmepriv->lock);
 	if (check_fwstate(pmlmepriv, state) == true)
@@ -554,7 +554,7 @@ __inline static void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-__inline static void set_scanned_network_val(struct mlme_priv *pmlmepriv, sint val)
+static inline void set_scanned_network_val(struct mlme_priv *pmlmepriv, sint val)
 {
 	spin_lock_bh(&pmlmepriv->lock);
 	pmlmepriv->num_of_scanned = val;
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 5de946e66302..012d8f54814f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -405,7 +405,7 @@ struct recv_buf *rtw_dequeue_recvbuf (struct __queue *queue);
 
 void rtw_reordering_ctrl_timeout_handler(struct timer_list *t);
 
-__inline static u8 *get_rxmem(union recv_frame *precvframe)
+static inline u8 *get_rxmem(union recv_frame *precvframe)
 {
 	/* always return rx_head... */
 	if (precvframe == NULL)
@@ -414,7 +414,7 @@ __inline static u8 *get_rxmem(union recv_frame *precvframe)
 	return precvframe->u.hdr.rx_head;
 }
 
-__inline static u8 *get_recvframe_data(union recv_frame *precvframe)
+static inline u8 *get_recvframe_data(union recv_frame *precvframe)
 {
 
 	/* alwasy return rx_data */
@@ -425,7 +425,7 @@ __inline static u8 *get_recvframe_data(union recv_frame *precvframe)
 
 }
 
-__inline static u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
+static inline u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
 {
 	/*  rx_data += sz; move rx_data sz bytes  hereafter */
 
@@ -450,7 +450,7 @@ __inline static u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
 
 }
 
-__inline static u8 *recvframe_put(union recv_frame *precvframe, sint sz)
+static inline u8 *recvframe_put(union recv_frame *precvframe, sint sz)
 {
 	/*  rx_tai += sz; move rx_tail sz bytes  hereafter */
 
@@ -479,7 +479,7 @@ __inline static u8 *recvframe_put(union recv_frame *precvframe, sint sz)
 
 
 
-__inline static u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
+static inline u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
 {
 	/*  rmv data from rx_tail (by yitsen) */
 
@@ -503,7 +503,7 @@ __inline static u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
 
 }
 
-__inline static union recv_frame *rxmem_to_recvframe(u8 *rxmem)
+static inline union recv_frame *rxmem_to_recvframe(u8 *rxmem)
 {
 	/* due to the design of 2048 bytes alignment of recv_frame, we can reference the union recv_frame */
 	/* from any given member of recv_frame. */
@@ -513,13 +513,13 @@ __inline static union recv_frame *rxmem_to_recvframe(u8 *rxmem)
 
 }
 
-__inline static sint get_recvframe_len(union recv_frame *precvframe)
+static inline sint get_recvframe_len(union recv_frame *precvframe)
 {
 	return precvframe->u.hdr.len;
 }
 
 
-__inline static s32 translate_percentage_to_dbm(u32 SignalStrengthIndex)
+static inline s32 translate_percentage_to_dbm(u32 SignalStrengthIndex)
 {
 	s32	SignalPower; /*  in dBm. */
 
diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index b9df42d0677e..3acce5630f8e 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -348,7 +348,7 @@ struct	sta_priv {
 };
 
 
-__inline static u32 wifi_mac_hash(u8 *mac)
+static inline u32 wifi_mac_hash(u8 *mac)
 {
         u32 x;
 
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 8c50bbb20f3b..2faf83704ff0 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -347,7 +347,7 @@ enum WIFI_REG_DOMAIN {
 	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
 )
 
-__inline static int IS_MCAST(unsigned char *da)
+static inline int IS_MCAST(unsigned char *da)
 {
 	if ((*da) & 0x01)
 		return true;
@@ -355,20 +355,20 @@ __inline static int IS_MCAST(unsigned char *da)
 		return false;
 }
 
-__inline static unsigned char * get_ra(unsigned char *pframe)
+static inline unsigned char * get_ra(unsigned char *pframe)
 {
 	unsigned char *ra;
 	ra = GetAddr1Ptr(pframe);
 	return ra;
 }
-__inline static unsigned char * get_ta(unsigned char *pframe)
+static inline unsigned char * get_ta(unsigned char *pframe)
 {
 	unsigned char *ta;
 	ta = GetAddr2Ptr(pframe);
 	return ta;
 }
 
-__inline static unsigned char * get_da(unsigned char *pframe)
+static inline unsigned char * get_da(unsigned char *pframe)
 {
 	unsigned char *da;
 	unsigned int	to_fr_ds	= (GetToDs(pframe) << 1) | GetFrDs(pframe);
@@ -392,7 +392,7 @@ __inline static unsigned char * get_da(unsigned char *pframe)
 }
 
 
-__inline static unsigned char * get_sa(unsigned char *pframe)
+static inline unsigned char * get_sa(unsigned char *pframe)
 {
 	unsigned char *sa;
 	unsigned int	to_fr_ds	= (GetToDs(pframe) << 1) | GetFrDs(pframe);
@@ -415,7 +415,7 @@ __inline static unsigned char * get_sa(unsigned char *pframe)
 	return sa;
 }
 
-__inline static unsigned char * get_hdr_bssid(unsigned char *pframe)
+static inline unsigned char * get_hdr_bssid(unsigned char *pframe)
 {
 	unsigned char *sa = NULL;
 	unsigned int	to_fr_ds	= (GetToDs(pframe) << 1) | GetFrDs(pframe);
@@ -439,7 +439,7 @@ __inline static unsigned char * get_hdr_bssid(unsigned char *pframe)
 }
 
 
-__inline static int IsFrameTypeCtrl(unsigned char *pframe)
+static inline int IsFrameTypeCtrl(unsigned char *pframe)
 {
 	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
 		return true;
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 88890b1c3c4c..723fc5b546ef 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -223,7 +223,7 @@ struct wlan_bssid_ex {
 	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and capability information) */
 } __packed;
 
-__inline  static uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
+static inline uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
 {
 	return (sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->IELength);
 }
-- 
2.20.1

