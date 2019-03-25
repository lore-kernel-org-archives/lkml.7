Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FA520883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEeEqR+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfCYCHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:07:47 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46047 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfCYCHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 22:07:47 -0400
Received: by mail-yw1-f68.google.com with SMTP id j128so5878240ywg.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RCLILY1adJof2yoBBhiIuIcwNYpF28SZRXMMqeDePCA=;
        b=XEeEqR+pqmx2NxA3F0aoWOlvPKZbCUldHNzALMk9jfb3ZNDj3IszCblbHiHGuLBdiR
         wOA0cuaOe8vWeokbLac7yWqRJ0dRvZwFWzkpgXwAFUR7puhWUHmNswSq7SpLpEl7vAv1
         aK64P0tol7fnG15MvUY/mEPFIAbJoBr/KGsx4p6NLLwexZY0xMuVmE+DhIaPNC9xVoyp
         OUW/SqGyIbFgme9ARKws608t3X5p+QgwIcOhpZNg6zuLweY2r5Plzyxlz+8g8Zu1Jk/o
         1PKOEHV4uLhEpvo+Y81qAoORehUrVqs19hlK2AUAzBR7tIkfyhfMtyZrzZ2DX4HOuvJJ
         5R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RCLILY1adJof2yoBBhiIuIcwNYpF28SZRXMMqeDePCA=;
        b=NhkzlhAHH/EnGlkrG4W3weU2hGxg5v+xApDEI1+scUxNdMWinK41nGpmwbF2JYy9vh
         F5AcmXckpRNYo/vj7dEWZ4rsoUoIRUbA6pjA6cURTYhLJI/TSjhJzacc+rRM/+zC+cpA
         CF7GNlMnztRIn1aT0+/258fxQX5PpaWy9RrWFo5zKbT4cD0cIVt5IQg6Zw+A2RRPfb3C
         8nyBf8wjuTvnRYPb6GFE43l94+7igTbuH2/EI92nHF2TYcGByDOsvgoqLMuYB4yoNg/D
         Qjn75Gxf1W33O2ilkRAslCUFN5AwaaNFOw47v44VCAaYcBvAXDUEsj+nAHrBGC0kp30c
         3EVQ==
X-Gm-Message-State: APjAAAUj+xEevxPbkVWO43dVAY1VKJexbtKoXABEwp/Eb5KuaLuReUPm
        llwXQPzpBISznrz6UOghaWE/jeRbQXAMIlkvnP4E7ShvnIo=
X-Google-Smtp-Source: APXvYqzn6C+56FrDUkwv8YTRJFc5zhO8Csvbak8pPOhFyv32oumOpTj2luebNt2CuMmKEKuUZb1rjG2DttuUXfaRxyI=
X-Received: by 2002:a25:38b:: with SMTP id 133mr17983177ybd.464.1553479665481;
 Sun, 24 Mar 2019 19:07:45 -0700 (PDT)
MIME-Version: 1.0
From:   Gen Zhang <blackgod016574@gmail.com>
Date:   Mon, 25 Mar 2019 10:07:39 +0800
Message-ID: <CAAie0aori8EmwNnmsYK17iYSQ1i0AwfkYEyyCq6-Tx_ptzLX7g@mail.gmail.com>
Subject: BUG: KASAN: stack-out-of-bounds in unwind_next_frame (*Reproducible*)
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think I found a reproducible kernel bug in version 5.0.4.
Source file: arch/x86/kernel/unwind_orc.c:505
The KASAN output is as following:
[   26.095365] BUG: KASAN: stack-out-of-bounds in
unwind_next_frame+0x1403/0x19e0
[   26.095365] Read of size 8 at addr ffff88805cc67d18 by task
syz-executor.0/2296
[   26.095365]
[   26.098418] CPU: 0 PID: 2296 Comm: syz-executor.0 Not tainted 5.0.4 #1
[   26.098418] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[   26.098418] Call Trace:
[   26.098418]  dump_stack+0xca/0x13e
[   26.098418]  ? unwind_next_frame+0x1403/0x19e0
[   26.098418]  print_address_description+0x67/0x237
[   26.098418]  ? unwind_next_frame+0x1403/0x19e0
[   26.098418]  ? unwind_next_frame+0x1403/0x19e0
[   26.098418]  kasan_report.cold.3+0x1a/0x3b
[   26.098418]  ? error_entry+0x40/0xf0
[   26.098418]  ? unwind_next_frame+0x1403/0x19e0
[   26.098418]  unwind_next_frame+0x1403/0x19e0
[   26.098418]  ? retint_kernel+0x10/0x10
[   26.098418]  ? deref_stack_reg+0xe0/0xe0
[   26.098418]  ? retint_kernel+0x10/0x10
[   26.098418]  perf_callchain_kernel+0x400/0x5b0
[   26.098418]  ? arch_perf_update_userpage+0x370/0x370
[   26.110600]  ? put_callchain_buffers+0x70/0x70
[   26.110600]  get_perf_callchain+0x370/0x800
[   26.110600]  ? put_callchain_buffers+0x70/0x70
[   26.110600]  ? perf_callchain+0x171/0x1c0
[   26.110600]  perf_callchain+0x163/0x1c0
[   26.110600]  perf_prepare_sample+0x88d/0x15a0
[   26.115655]  ? perf_callchain+0x1c0/0x1c0
[   26.115655]  ? perf_prepare_sample+0x15a0/0x15a0
[   26.115655]  ? perf_event_output_forward+0x1bf/0x2a0
[   26.115655]  perf_event_output_forward+0x108/0x2a0
[   26.115655]  ? perf_prepare_sample+0x15a0/0x15a0
[   26.115655]  ? __perf_event_overflow+0x1e7/0x360
[   26.115655]  ? perf_swevent_overflow+0x8d/0x140
[   26.115655]  __perf_event_overflow+0x13f/0x360
[   26.115655]  perf_swevent_overflow+0xa7/0x140
[   26.115655]  perf_swevent_event+0x14d/0x2e0
[   26.115655]  perf_tp_event+0x26a/0x880
[   26.115655]  ? perf_swevent_event+0x2e0/0x2e0
[   26.115655]  ? perf_pmu_nop_int+0x5/0x10
[   26.115655]  ? group_sched_in+0x177/0x3f0
[   26.115655]  ? flexible_sched_in+0xbc/0x5f0
[   26.115655]  ? __lock_acquire+0x5d6/0x4630
[   26.115655]  ? perf_trace_run_bpf_submit+0x112/0x1b0
[   26.115655]  ? perf_trace_run_bpf_submit+0x112/0x1b0
[   26.115655]  perf_trace_run_bpf_submit+0x112/0x1b0
[   26.115655]  ? memset+0x1f/0x40
[   26.115655]  perf_trace_lock_acquire+0x374/0x630
[   26.115655]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   26.115655]  ? perf_trace_lock+0x520/0x520
[   26.115655]  ? retint_kernel+0x10/0x10
[   26.115655]  lock_acquire+0x1ed/0x2e0
[   26.115655]  ? posix_ktime_get_ts+0x11/0x20
[   26.115655]  ktime_get_ts64+0x187/0x2e0
[   26.115655]  ? posix_ktime_get_ts+0x11/0x20
[   26.115655]  ? __x64_sys_futex+0x35b/0x4e0
[   26.115655]  posix_ktime_get_ts+0x11/0x20
[   26.115655]  __x64_sys_clock_gettime+0x152/0x240
[   26.115655]  ? __x64_sys_timer_create+0x1b0/0x1b0
[   26.115655]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   26.115655]  ? trace_hardirqs_off_caller+0x55/0x1c0
[   26.115655]  ? do_syscall_64+0x1a/0x4e0
[   26.115655]  do_syscall_64+0xbc/0x4e0
[   26.115655]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   26.115655] RIP: 0033:0x45b37a
[   26.115655] Code: 31 f6 31 ff e8 27 fe ff ff b8 40 6b a4 00 48 83
c4 08 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 63 ff b8 e4 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 02 f3 c3 48 c7 c2 d4 ff ff ff f7 d8 64
89 02
[   26.115655] RSP: 002b:00007f2d0f4d3c78 EFLAGS: 00000202 ORIG_RAX:
00000000000000e4
[   26.115655] RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 000000000045b37a
[   26.115655] RDX: 00000000004b587f RSI: 00007f2d0f4d3c80 RDI: 0000000000000001
[   26.115655] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f2d0f4d4700
[   26.115655] R10: 0000000000000003 R11: 0000000000000202 R12: 00000000004b587f
[   26.115655] R13: 00000000004c9050 R14: 00007f2d0f4d49c0 R15: 00007f2d0f4d4700
[   26.115655]
[   26.115655] The buggy address belongs to the page:
[   26.115655] page:ffffea00017319c0 count:0 mapcount:0
mapping:0000000000000000 index:0x0
[   26.115655] flags: 0x100000000000000()
[   26.115655] raw: 0100000000000000 ffffea00017319c8 ffffea00017319c8
0000000000000000
[   26.115655] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[   26.115655] page dumped because: kasan: bad access detected
[   26.115655]
[   26.115655] Memory state around the buggy address:
[   26.115655]  ffff88805cc67c00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   26.115655]  ffff88805cc67c80: 00 00 00 00 00 00 00 00 00 00 00 f1
f1 f1 f1 04
[   26.115655] >ffff88805cc67d00: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00
00 00 00 00
[   26.115655]                             ^
[   26.115655]  ffff88805cc67d80: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   26.115655]  ffff88805cc67e00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00

And the c reproducer is:
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

static void sleep_ms(uint64_t ms)
{
usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts))
exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
pthread_t th;
pthread_attr_t attr;
pthread_attr_init(&attr);
pthread_attr_setstacksize(&attr, 128 << 10);
int i;
for (i = 0; i < 100; i++) {
if (pthread_create(&th, &attr, fn, arg) == 0) {
pthread_attr_destroy(&attr);
return;
}
if (errno == EAGAIN) {
usleep(50);
continue;
}
break;
}
exit(1);
}

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len)
*(type*)(addr) = htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off),
(bf_len))) | (((type)(val) << (bf_off)) & BITMASK((bf_off),
(bf_len))))

typedef struct {
int state;
} event_t;

static void event_init(event_t* ev)
{
ev->state = 0;
}

static void event_reset(event_t* ev)
{
ev->state = 0;
}

static void event_set(event_t* ev)
{
if (ev->state)
exit(1);
__atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG);
}

static void event_wait(event_t* ev)
{
while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
uint64_t start = current_time_ms();
uint64_t now = start;
for (;;) {
uint64_t remain = timeout - (now - start);
struct timespec ts;
ts.tv_sec = remain / 1000;
ts.tv_nsec = (remain % 1000) * 1000 * 1000;
syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
if (__atomic_load_n(&ev->state, __ATOMIC_RELAXED))
return 1;
now = current_time_ms();
if (now - start > timeout)
return 0;
}
}

static bool write_file(const char* file, const char* what, ...)
{
char buf[1024];
va_list args;
va_start(args, what);
vsnprintf(buf, sizeof(buf), what, args);
va_end(args);
buf[sizeof(buf) - 1] = 0;
int len = strlen(buf);
int fd = open(file, O_WRONLY | O_CLOEXEC);
if (fd == -1)
return false;
if (write(fd, buf, len) != len) {
int err = errno;
close(fd);
errno = err;
return false;
}
close(fd);
return true;
}

static void kill_and_wait(int pid, int* status)
{
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
int i;
for (i = 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) == pid)
return;
usleep(1000);
}
DIR* dir = opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent = readdir(dir);
if (!ent)
break;
if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd = open(abort, O_WRONLY);
if (fd == -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) != pid) {
}
}

#define SYZ_HAVE_SETUP_TEST 1
static void setup_test()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

#define SYZ_HAVE_RESET_TEST 1
static void reset_test()
{
int fd;
for (fd = 3; fd < 30; fd++)
close(fd);
}

struct thread_t {
int created, call;
event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
struct thread_t* th = (struct thread_t*)arg;
for (;;) {
event_wait(&th->ready);
event_reset(&th->ready);
execute_call(th->call);
__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
event_set(&th->done);
}
return 0;
}

static void execute_one(void)
{
int i, call, thread;
int collide = 0;
again:
for (call = 0; call < 1; call++) {
for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
thread++) {
struct thread_t* th = &threads[thread];
if (!th->created) {
th->created = 1;
event_init(&th->ready);
event_init(&th->done);
event_set(&th->done);
thread_start(thr, th);
}
if (!event_isset(&th->done))
continue;
event_reset(&th->done);
th->call = call;
__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
event_set(&th->ready);
if (collide && (call % 2) == 0)
break;
event_timedwait(&th->done, 45);
break;
}
}
for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
sleep_ms(1);
if (!collide) {
collide = 1;
goto again;
}
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
int iter;
for (iter = 0;; iter++) {
int pid = fork();
if (pid < 0)
exit(1);
if (pid == 0) {
setup_test();
execute_one();
reset_test();
exit(0);
}
int status = 0;
uint64_t start = current_time_ms();
for (;;) {
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
break;
sleep_ms(1);
if (current_time_ms() - start < 5 * 1000)
continue;
kill_and_wait(pid, &status);
break;
}
}
}

void execute_call(int call)
{
switch (call) {
case 0:
*(uint32_t*)0x20000040 = 2;
*(uint32_t*)0x20000044 = 0x70;
*(uint8_t*)0x20000048 = 0x74;
*(uint8_t*)0x20000049 = 0;
*(uint8_t*)0x2000004a = 0;
*(uint8_t*)0x2000004b = 0;
*(uint32_t*)0x2000004c = 0;
*(uint64_t*)0x20000050 = 3;
*(uint64_t*)0x20000058 = 0x20;
*(uint64_t*)0x20000060 = 0;
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 0, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 1, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 2, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 3, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 4, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 5, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 6, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 7, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 8, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 9, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 10, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 11, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 12, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 13, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 14, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 15, 2);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 17, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 18, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 19, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 20, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 21, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 22, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 23, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 24, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 25, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 26, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 27, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 28, 1);
STORE_BY_BITMASK(uint64_t, , 0x20000068, 0, 29, 35);
*(uint32_t*)0x20000070 = 0;
*(uint32_t*)0x20000074 = 0;
*(uint64_t*)0x20000078 = 0;
*(uint64_t*)0x20000080 = 0;
*(uint64_t*)0x20000088 = 0;
*(uint64_t*)0x20000090 = 0;
*(uint32_t*)0x20000098 = 0;
*(uint32_t*)0x2000009c = 0;
*(uint64_t*)0x200000a0 = 0;
*(uint32_t*)0x200000a8 = 0;
*(uint16_t*)0x200000ac = 0;
*(uint16_t*)0x200000ae = 0;
syscall(__NR_perf_event_open, 0x20000040, 0, 0, -1, 0);
break;
}

}
int main(void)
{
syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
loop();
return 0;
}


Looking forward to your reply
Alex
